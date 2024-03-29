import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class JobSeeker with ChangeNotifier {
  final String id;
  final String firstName;
  final String lastName;
  final String jobTitle;
  final String jobType;
  final String locationName;
  final double latitude;
  final double longitude;
  final List<String> skills;
  final String url;
  final bool isAvailable;
  final bool searchableWhenUnavailable;

  JobSeeker({
    this.id,
    this.firstName,
    this.lastName,
    this.jobTitle,
    this.jobType,
    this.locationName,
    this.latitude,
    this.longitude,
    this.skills,
    this.url,
    this.isAvailable,
    this.searchableWhenUnavailable,
  });
}
