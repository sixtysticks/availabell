import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Recruiter with ChangeNotifier {
  final String id;
  final String firstName;
  final String lastName;
  final String location;

  Recruiter({
    this.id,
    this.firstName,
    this.lastName,
    this.location,
  });
}
