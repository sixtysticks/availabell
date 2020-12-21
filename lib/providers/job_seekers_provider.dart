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
      jobType: 'Full Time',
      locationName: 'Birmingham, UK',
      skills: [
        'Flutter',
        'Swift',
      ],
      isAvailable: true,
      worksRemote: true,
    ),
    JobSeeker(
      id: '2',
      firstName: 'Dan',
      lastName: 'Eltis',
      jobTitle: 'CTO at PORT Tech',
      jobType: 'Contract',
      locationName: 'Cambridge, UK',
      skills: [
        'Java',
        'MVC',
        'Spring',
      ],
      isAvailable: true,
      worksRemote: false,
    ),
    JobSeeker(
      id: '3',
      firstName: 'Ed',
      lastName: 'Brindley',
      jobTitle: 'Software Developer',
      jobType: 'Part Time',
      locationName: 'Sheffield, UK',
      skills: [
        'Java',
        'Python',
        'Raspberry Pi',
        'Macintosh Pro English',
      ],
      isAvailable: false,
      worksRemote: true,
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
          'skills': jobSeeker.skills
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
