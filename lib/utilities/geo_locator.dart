import 'dart:math';

import 'package:availabell/widgets/misc/globals.dart' as globals;

class Geolocator {
  //Find the distance between two points (m)
  //The version you seek from the Hubeni formula
  //mode Land Survey System true:world(default) false:japan
  //@return double distance(m)
  static double distanceBetween(lat1, lon1, lat2, lon2, {mode = true}) {
    // Convert longitude and latitude to radians
    final radLat1 = lat1 * pi / 180;
    final radLon1 = lon1 * pi / 180;
    final radLat2 = lat2 * pi / 180;
    final radLon2 = lon2 * pi / 180;

    // Latitude difference
    final radLatDiff = radLat1 - radLat2;

    // longitude and latitude difference
    final radLonDiff = radLon1 - radLon2;

    // Average Latitude
    final radLatAve = (radLat1 + radLat2) / 2.0;

    // Difference in values by geodetic system
    final a = mode ? 6378137.0 : 6377397.155; // Equatorial radius
    // final b = mode ? 6356752.314140356 : 6356078.963; // Extreme Radius
    final e2 = mode ? 0.00669438002301188 : 0.00667436061028297; // primary eccentricity^2
    final a1e2 = mode ? 6335439.32708317 : 6334832.10663254; // Meridian radius of curvature at the equator

    final sinLat = sin(radLatAve);
    final w2 = 1.0 - e2 * (sinLat * sinLat);
    final m = a1e2 / (sqrt(w2) * w2);
    final n = a / sqrt(w2);
    final t1 = m * radLatDiff;
    final t2 = n * cos(radLatAve) * radLonDiff;
    final dist = sqrt((t1 * t1) + (t2 * t2));

    return dist;
  }

  String formatDistanceBetween2Coords(lat, lon) {
    double distanceInMetres = distanceBetween(globals.hardcodedLat, globals.hardcodedLon, lat, lon);
    int totalDistance = ((distanceInMetres / 1.609) / 1000).round();

    return (totalDistance == 1) ? 'Less than a mile away' : '${totalDistance.toString()} miles away';
  }
}
