// Dependency imports
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

// Availabell imports
import 'package:availabell/models/job_seeker.dart';
import 'package:availabell/widgets/components/av_listing.dart';
import 'package:availabell/widgets/misc/globals.dart' as globals;

class JobSeekerList extends StatelessWidget {
  final List<JobSeeker> jobSeekers;
  final String emptyListMessage;
  final ScrollController _scrollController = ScrollController();

  JobSeekerList({
    Key key,
    this.jobSeekers,
    this.emptyListMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: jobSeekers.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(globals.spacer),
                      child: Text(
                        emptyListMessage,
                        style: Theme.of(context).textTheme.headline1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              padding: const EdgeInsets.only(top: globals.halfSpacer),
              controller: _scrollController,
              itemCount: jobSeekers.length,
              itemBuilder: (context, index) {
                return ChangeNotifierProvider.value(
                  value: jobSeekers[index],
                  child: JobSeekerListing(jobSeekerId: jobSeekers[index].id),
                );
              },
            ),
    );
  }
}
