import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_map/map_api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';
import 'package:test_map/models/door.dart';

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

  static Stream<Position?> getStream() async* {
    try {
      if (await _isEnabled() && await _requestPermission()) {
        yield* Geolocator.getPositionStream(
          locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
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

  static Future<double> getDistance(LatLng origin, LatLng destination) async {
    // this is canceled.
    final apiKey = maps_api;
    final url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?origins=${origin.latitude},${origin.longitude}&destinations=${destination.latitude},${destination.longitude}&key=$apiKey";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        // Check if the response contains distance information
        if (data['rows'] != null &&
            data['rows'].isNotEmpty &&
            data['rows'][0]['elements'] != null &&
            data['rows'][0]['elements'].isNotEmpty &&
            data['rows'][0]['elements'][0]['distance'] != null) {
          // Parse the distance from the response
          final distanceText = data['rows'][0]['elements'][0]['distance']['text'];
          final distanceValue = double.parse(distanceText.split(' ')[0]);
          return distanceValue;
        } else {
          throw Exception('Failed to retrieve distance information');
        }
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print('Error: $e');
      return Future.error('Failed to fetch distance data');
    }
  }

  static double getDistanceGeometrical(LatLng origin, LatLng destination) {
    return sqrt(pow((origin.latitude - destination.latitude), 2) +
        pow((origin.longitude - destination.longitude), 2));
  }

  static LatLng getClosestLocation(LatLng location, List<DoorElement> doors) {
    double minDistance = double.infinity;
    LatLng closestLocation = doors.first.coordinates;

    for (DoorElement door in doors) {
      double distance = getDistanceGeometrical(location, door.coordinates);
      if (distance < minDistance) {
        minDistance = distance;
        closestLocation = door.coordinates;
      }
    }

    return closestLocation;
  }

  static DoorElement getClosestDoor(LatLng location, List<DoorElement> doors) {
    double minDistance = 300.0;
    DoorElement closestDoor = doors.first;

    for (DoorElement door in doors) {
      double distance = getDistanceGeometrical(location, door.coordinates);
      if (distance < minDistance) {
        minDistance = distance;
        closestDoor = door;
      }
    }

    return closestDoor;
  }
}
