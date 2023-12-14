import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_map/services/LocationService.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentLocation;
  LatLng? _targetLocation;

  Position? get currentLocation => _currentLocation;
  LatLng? get targetLocation => _targetLocation;

  LocationProvider() {
    LocationService.getStream().listen((Position? position) {
      _currentLocation = position;
      notifyListeners();
    });
  }

  void setNewTarget(LatLng target) {
    _targetLocation = target;
    notifyListeners();
  }
}
