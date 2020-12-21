// navigator.geolocation namespace
@JS('navigator.geolocation')

// library name can be whatever you want
library jslocation;

import 'package:js/js.dart';

// Accessing method getCurrentPosition from Geolocation API
@JS('getCurrentPosition')
external void getCurrentPosition(Function success(GeolocationPosition pos));

@JS()
@anonymous
class GeolocationPosition {
  external factory GeolocationPosition({GeolocationCoordinates coords});

  external GeolocationCoordinates get coords;
}

@JS()
@anonymous
class GeolocationCoordinates {
  external factory GeolocationCoordinates({
    double latitude,
    double longitude,
  });

  external double get latitude;
  external double get longitude;
}
