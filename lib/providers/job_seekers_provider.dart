// Dependency imports
import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

// Availabell imports
import 'package:availabell/models/job_seeker.dart';
import 'package:availabell/widgets/misc/globals.dart' as globals;

class JobSeekersProvider with ChangeNotifier {
  List<JobSeeker> _jobseekers = [
    JobSeeker(
      id: '1',
      firstName: 'David',
      lastName: 'Gibbs',
      jobTitle: 'Mobile App Developer',
      jobType: 'Full-time',
      locationName: 'Sutton Coldfield, West Midlands, England, United Kingdom',
      skills: [
        'Flutter',
        'iOS Development',
      ],
      latitude: 52.5807836,
      longitude: -1.8247012,
      url: 'https://www.linkedin.com/in/sixtysticks/',
      isAvailable: true,
      searchableWhenUnavailable: true,
    ),
    JobSeeker(
      id: '2',
      firstName: 'Peter',
      lastName: 'Piper',
      jobTitle: 'Actor',
      jobType: 'Part-time',
      locationName: 'Derby, Derbyshire England, United Kingdom',
      skills: [
        'Drama',
        'Stage Fighting',
      ],
      latitude: 52.921902,
      longitude: -1.475640,
      url: 'https://www.sixtysticks.com/',
      isAvailable: false,
      searchableWhenUnavailable: true,
    ),
    JobSeeker(
      id: '3',
      firstName: 'Paul',
      lastName: 'Gascoigne',
      jobTitle: 'Footballer',
      jobType: 'Part-time',
      locationName: 'Newcastle, United Kingdom',
      skills: [
        'Scoring',
        'Crying',
      ],
      latitude: 54.977840,
      longitude: -1.612920,
      url: 'https://www.twitter.com/sixtysticks',
      isAvailable: true,
      searchableWhenUnavailable: false,
    ),
  ];

  List<JobSeeker> get jobseekers {
    return [..._jobseekers]; // Returns a copy of the _jobseekers list
  }

  JobSeeker findById(String jobSeekerId) {
    return _jobseekers.firstWhere((jobseeker) => jobseeker.id == jobSeekerId);
  }

  Future<void> postJobSeekerToFirebase(JobSeeker jobSeeker) async {
    const url = globals.firebaseUrlJobSeekers;
    try {
      final response = await http.post(
        url,
        body: json.encode({
          'id': jobSeeker.id,
          'first_name': jobSeeker.firstName,
          'last_name': jobSeeker.lastName,
          'job_title': jobSeeker.jobTitle,
          'job_type': jobSeeker.jobType,
          'location_name': jobSeeker.locationName,
          'latitude': jobSeeker.latitude,
          'longitude': jobSeeker.longitude,
          'skills': jobSeeker.skills,
          'url': jobSeeker.url,
          'is_available': jobSeeker.isAvailable,
          'searchable_when_unavailable': jobSeeker.searchableWhenUnavailable,
        }),
      );
      print(response.body);
    } catch (error) {
      print(error);
      throw error;
    }

    _jobseekers.add(jobSeeker);
    notifyListeners();
  }

  String getFullName(String jobSeekerId) {
    final jobSeeker = findById(jobSeekerId);
    return '${jobSeeker.firstName} ${jobSeeker.lastName}';
  }
}
