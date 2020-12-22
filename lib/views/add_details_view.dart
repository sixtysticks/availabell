// Dependency imports
import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tags/flutter_tags.dart';
import 'package:js/js.dart';
import 'package:mapbox_geocoding/mapbox_geocoding.dart';
import 'package:mapbox_geocoding/model/reverse_geocoding.dart';
import 'package:provider/provider.dart';

// Availabell imports
import 'package:availabell/models/job_seeker.dart';
import 'package:availabell/models/location.dart';
import 'package:availabell/models/skills.dart';
import 'package:availabell/providers/job_seekers_provider.dart';
import 'package:availabell/widgets/misc/globals.dart' as globals;
import 'package:availabell/widgets/ui/av_button.dart';
import 'package:availabell/widgets/ui/av_scaffold.dart';
import 'package:availabell/widgets/ui/av_text_form_field.dart';
import 'package:availabell/widgets/ui/av_themes.dart';

class AVDropdownListItem {
  int value;
  String name;

  AVDropdownListItem(
    this.value,
    this.name,
  );
}

class AddDetailsView extends StatefulWidget {
  static const routeName = globals.addDetailsRoute;

  AddDetailsView({
    Key key,
  }) : super(key: key);

  @override
  _AddDetailsViewState createState() => _AddDetailsViewState();
}

class _AddDetailsViewState extends State<AddDetailsView> {
  final _form = GlobalKey<FormState>();
  var _editedJobSeeker = JobSeeker(
    firstName: '',
    lastName: '',
    jobTitle: '',
    jobType: '',
    locationName: '',
    latitude: 0.0,
    longitude: 0.0,
    skills: [],
    isAvailable: false,
    worksRemote: false,
  );

  /**
   * Job Type field variables/functions
   */

  List<AVDropdownListItem> _jobTypes = [
    AVDropdownListItem(1, globals.fullTimeLabel),
    AVDropdownListItem(2, globals.contractLabel),
    AVDropdownListItem(3, globals.partTimeLabel),
    AVDropdownListItem(4, globals.temporaryLabel),
  ];

  List<DropdownMenuItem<AVDropdownListItem>> _jobTypeMenuItems;
  AVDropdownListItem _selectedJobType;

  List<DropdownMenuItem<AVDropdownListItem>> buildDropDownMenuItems(List listItems) {
    List<DropdownMenuItem<AVDropdownListItem>> items = [];
    for (AVDropdownListItem listItem in listItems) {
      items.add(
        DropdownMenuItem(
          child: Text(listItem.name),
          value: listItem,
        ),
      );
    }
    return items;
  }

  /**
   * Location field variables/functions
   */

  MapboxGeocoding geocoding = MapboxGeocoding(globals.mapBoxAccessToken);
  double _latitude = 0.0;
  double _longitude = 0.0;
  String _locationName = '';

  dynamic getCity(double lat, double lng) async {
    try {
      ReverseGeocoding reverseModel = await geocoding.reverseModel(lat, lng, limit: 7, types: 'place');
      print(reverseModel.features[0].placeName);

      setState(() {
        _locationName = reverseModel.features[0].placeName;
      });
    } catch (Exception) {
      return 'Reverse Geocoding Error';
    }
  }

  /**
   * Skills field variables/functions
   */

  List<String> _skillsList = Skills().getSkills;
  List<String> _chosenSkills = [];
  List<String> _skillsListItems = [];

  // ignore: unused_field
  final GlobalKey<TagsState> _skillStateKey = GlobalKey<TagsState>();

  Widget get _skillsTags {
    return Tags(
      alignment: WrapAlignment.start,
      spacing: globals.halfSpacer / 2,
      runAlignment: WrapAlignment.start,
      runSpacing: globals.halfSpacer / 2,
      itemCount: _skillsListItems.length,
      textField: _skillsListItems.length < 5 ? _textField : null,
      itemBuilder: (index) {
        final item = _skillsListItems[index].toUpperCase();

        return ItemTags(
          alignment: MainAxisAlignment.start,
          key: Key(index.toString()),
          elevation: 0,
          index: index,
          title: item,
          pressEnabled: false,
          singleItem: true,
          color: AVThemes.avLightGreyColor,
          border: Border(),
          borderRadius: BorderRadius.zero,
          combine: ItemTagsCombine.withTextBefore,
          padding: EdgeInsets.symmetric(horizontal: globals.halfSpacer, vertical: globals.halfSpacer),
          removeButton: ItemTagsRemoveButton(
            backgroundColor: AVThemes.avGreyColor,
            borderRadius: BorderRadius.zero,
            onRemoved: () {
              setState(() {
                _skillsList.add(item.toUpperCase());
                _skillsListItems.removeAt(index);
              });
              return true;
            },
          ),
          textStyle: Theme.of(context).textTheme.caption,
        );
      },
    );
  }

  TagsTextField get _textField {
    return TagsTextField(
      keyboardType: TextInputType.text,
      width: double.infinity,
      padding: EdgeInsets.zero,
      autofocus: false,
      hintText: 'Enter your main skills (5 max)',
      hintTextColor: AVThemes.avGreyColor,
      helperText: 'No skills match the keyword',
      helperTextStyle: Theme.of(context).textTheme.caption,
      suggestionTextColor: AVThemes.avGreyColor,
      textStyle: Theme.of(context).textTheme.bodyText1,
      constraintSuggestion: false,
      enabled: true,
      suggestions: _skillsList,
      onSubmitted: (String str) {
        setState(() {
          _skillsList.remove(str);
          _skillsListItems.add(str);
        });
      },
    );
  }

  /**
   * Save the form and post to Firebase
   */

  void _saveForm(jobSeeker) {
    final isValid = _form.currentState.validate();
    if (!isValid) {
      return;
    }
    _form.currentState.save();
    jobSeeker.postJobSeekerToFirebase(_editedJobSeeker).catchError(
      (error) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('The error: $error'),
            actions: <Widget>[
              FlatButton(
                child: Text('Close'),
                onPressed: () => {
                  Navigator.of(context).pop(),
                },
              ),
            ],
          ),
        );
      },
    );
    Navigator.of(context).pop();
  }

  /**
   * Initialise the class state and build widget
   */

  @override
  void initState() {
    super.initState();
    _jobTypeMenuItems = buildDropDownMenuItems(_jobTypes);
    _selectedJobType = _jobTypeMenuItems[0].value;
    getCurrentPosition(allowInterop((pos) {
      setState(() {
        _latitude = pos.coords.latitude;
        _longitude = pos.coords.longitude;
      });
      getCity(_latitude, _longitude);
      return null;
    }));
    _skillsListItems = _chosenSkills.toList();
  }

  @override
  Widget build(BuildContext context) {
    final jobSeeker = Provider.of<JobSeekersProvider>(context);

    return AVScaffold(
      appBarActions: null,
      title: Text('Add your details'),
      backgroundColor: AVThemes.avLightColor,
      screenContent: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Container(
          color: AVThemes.avLightColor,
          child: SingleChildScrollView(
            padding: EdgeInsets.all(globals.spacer),
            child: Column(
              children: <Widget>[
                Form(
                  key: _form,
                  child: Column(
                    children: <Widget>[
                      AVTextFormField(
                        labelText: globals.firstNameLabel,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a first name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedJobSeeker = JobSeeker(
                            firstName: value,
                            lastName: _editedJobSeeker.lastName,
                            jobTitle: _editedJobSeeker.jobTitle,
                            jobType: _editedJobSeeker.jobType,
                            locationName: _locationName,
                            latitude: _latitude,
                            longitude: _longitude,
                            skills: _skillsListItems.isNotEmpty ? _skillsListItems : [],
                          );
                        },
                      ),
                      SizedBox(height: globals.halfSpacer),
                      AVTextFormField(
                        labelText: globals.lastNameLabel,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a last name';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedJobSeeker = JobSeeker(
                            firstName: _editedJobSeeker.firstName,
                            lastName: value,
                            jobTitle: _editedJobSeeker.jobTitle,
                            jobType: _editedJobSeeker.jobType,
                            locationName: _locationName,
                            latitude: _latitude,
                            longitude: _longitude,
                            skills: _skillsListItems.isNotEmpty ? _skillsListItems : [],
                          );
                        },
                      ),
                      SizedBox(height: globals.halfSpacer),
                      AVTextFormField(
                        labelText: globals.jobTitleLabel,
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please provide a job title';
                          }
                          return null;
                        },
                        onSaved: (value) {
                          _editedJobSeeker = JobSeeker(
                            firstName: _editedJobSeeker.firstName,
                            lastName: _editedJobSeeker.lastName,
                            jobTitle: value,
                            jobType: _editedJobSeeker.jobType,
                            locationName: _locationName,
                            latitude: _latitude,
                            longitude: _longitude,
                            skills: _skillsListItems.isNotEmpty ? _skillsListItems : [],
                          );
                        },
                      ),
                      SizedBox(height: globals.halfSpacer),
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                            ),
                            child: Text(
                              globals.jobTypeLabel,
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(left: globals.halfSpacer, right: globals.halfSpacer),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5.0),
                              color: AVThemes.avLightColor,
                              border: Border.all(
                                color: AVThemes.avGreyColor,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                  value: _selectedJobType,
                                  items: _jobTypeMenuItems,
                                  focusColor: Colors.white,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedJobType = value;
                                    });
                                    _editedJobSeeker = JobSeeker(
                                      firstName: _editedJobSeeker.firstName,
                                      lastName: _editedJobSeeker.lastName,
                                      jobTitle: _editedJobSeeker.jobTitle,
                                      locationName: _locationName,
                                      jobType: value.name,
                                      latitude: _latitude,
                                      longitude: _longitude,
                                      skills: _skillsListItems.isNotEmpty ? _skillsListItems : [],
                                    );
                                  }),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: globals.spacer),
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                            ),
                            child: Text(
                              globals.locationLabel,
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Text(
                              _locationName,
                              style: Theme.of(context).textTheme.headline2,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: globals.spacer),
                      Column(
                        children: [
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(
                              vertical: 6.0,
                            ),
                            child: Text(
                              globals.skillsLabel,
                              style: Theme.of(context).textTheme.bodyText1,
                              textAlign: TextAlign.start,
                            ),
                          ),
                          _skillsTags
                        ],
                      ),
                      SizedBox(height: 30.0),
                      SGButton(
                        buttonText: globals.finishLabel,
                        onPressed: () {
                          _saveForm(jobSeeker);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
