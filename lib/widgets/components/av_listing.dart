// Dependency imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Availabell imports
import 'package:availabell/providers/job_seekers_provider.dart';
import 'package:availabell/widgets/misc/globals.dart' as globals;
import 'package:availabell/widgets/ui/av_themes.dart';

class JobSeekerListing extends StatelessWidget {
  final String jobSeekerId;

  JobSeekerListing({
    Key key,
    this.jobSeekerId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final jobSeeker = Provider.of<JobSeekersProvider>(context).findById(jobSeekerId);
    final jobSeekerFullName = Provider.of<JobSeekersProvider>(context).getFullName(jobSeekerId);

    Widget buildSkillsComponent() {
      List<Widget> skillList = <Widget>[];

      if (jobSeeker.skills != null) {
        for (var skill in jobSeeker.skills) {
          skillList.add(
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 4.0, 4.0, 0),
              child: Container(
                padding: EdgeInsets.fromLTRB(
                  globals.halfSpacer,
                  globals.halfSpacer / 2,
                  globals.halfSpacer,
                  6.0,
                ),
                color: AVThemes.avLightGreyColor,
                child: Text(
                  skill.toUpperCase(),
                  style: Theme.of(context).textTheme.caption,
                ),
              ),
            ),
          );
        }
        return Wrap(
          children: skillList,
        );
      }
      return Container();
    }

    return GestureDetector(
      onTap: () {},
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.fromLTRB(
          globals.halfSpacer,
          0.0,
          globals.halfSpacer,
          globals.halfSpacer,
        ),
        child: ListTile(
          minLeadingWidth: globals.spacer,
          leading: Column(
            children: [
              Container(
                child: CircleAvatar(
                  backgroundColor: AVThemes.avPrimaryColor,
                  radius: 7,
                ),
              ),
            ],
          ),
          title: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(vertical: globals.halfSpacer),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jobSeekerFullName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headline1,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: globals.halfSpacer / 3),
                      child: Text(
                        jobSeeker.jobTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                    Container(
                      width: 210,
                      child: Text(
                        jobSeeker.locationName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                    Container(
                      width: 210,
                      padding: EdgeInsets.only(top: 6.0),
                      child: buildSkillsComponent(),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
