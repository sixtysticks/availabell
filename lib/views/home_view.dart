// Dependency imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Availabell imports
import 'package:availabell/providers/job_seekers_provider.dart';
import 'package:availabell/views/add_details_view.dart';
import 'package:availabell/widgets/components/av_list.dart';
import 'package:availabell/widgets/misc/globals.dart' as globals;
import 'package:availabell/widgets/ui/av_scaffold.dart';
import 'package:availabell/widgets/ui/av_themes.dart';

class HomeView extends StatelessWidget {
  static const routeName = globals.homeRoute;

  HomeView({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jobSeekers = Provider.of<JobSeekersProvider>(context).jobseekers;
    int numOfJobSeekers = jobSeekers.length;
    bool onlyOneJobSeeker = numOfJobSeekers == 1;
    String isOrAre = onlyOneJobSeeker ? 'is' : 'are';
    String personOrPeople = onlyOneJobSeeker ? 'person' : 'people';

    return AVScaffold(
      title: Image.asset(
        globals.avLogo,
        fit: BoxFit.contain,
        height: 24.0,
      ),
      appBarActions: <Widget>[
        IconButton(
          icon: Icon(Icons.add),
          color: AVThemes.avDarkColor,
          onPressed: () {
            Navigator.of(context).pushNamed(AddDetailsView.routeName);
          },
        ),
      ],
      backgroundColor: AVThemes.avLightGreyColor,
      screenContent: Container(
        child: Column(
          children: <Widget>[
            Container(
              color: AVThemes.avPrimaryColor[500],
              width: double.infinity,
              padding: EdgeInsets.symmetric(vertical: globals.halfSpacer),
              child: Column(
                children: [
                  Text(
                    'There ${isOrAre} ${numOfJobSeekers} ${personOrPeople} available nearby',
                    style: Theme.of(context).textTheme.headline3,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            Expanded(
              child: JobSeekerList(
                jobSeekers: jobSeekers,
                emptyListMessage: globals.noJobSeekersLabel,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
