import 'dart:async';

import 'package:geolocator/geolocator.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    if (await _isEnabled()) {
      if (await _requestPermission()) {
        return await Geolocator.getCurrentPosition();
      } else {
        return Future.error("Not enough permission");
      }
    } else {
      return Future.error("Location service is disabled");
    }
  }

/*
  static Stream<Position?> getStream() {
    return Geolocator.getPositionStream(
        locationSettings: LocationSettings(accuracy: LocationAccuracy.high));
  }
  */

  static Stream<Position?> getStream() async* {
    try {
      if (await _isEnabled() && await _requestPermission()) {
        yield* Geolocator.getPositionStream(
          locationSettings: LocationSettings(accuracy: LocationAccuracy.high),
        );
      } else {
        throw Exception("Location permission denied");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  static Future<bool> _isEnabled() async {
    bool isEnabled = await Geolocator.isLocationServiceEnabled();

    if (!isEnabled) {
      return Future.error("Loc service is disabled");
    }
    return true;
  }

  static Future<bool> _requestPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();

      if (permission == LocationPermission.deniedForever) {
        return Future.error("Loc service is disabled permanently.");
      }
      if (permission == LocationPermission.denied) {
        return Future.error("Loc service is denied.");
      } else {
        return true;
      }
    }
    return true;
  }
}
