import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_map/models/class.dart';
import 'package:test_map/models/door.dart';
import 'package:test_map/services/LocationService.dart';

class LocationProvider with ChangeNotifier {
  Position? _currentLocation;
  LatLng? _targetLocation;
  DoorElement? _targetDoor;
  ClassElement? _targetClass;
  bool _isReached = false;
  double _distance = 0.0;
  //----------
  double _speed = 0.0;
  double _altitude = 0.0;

  int _floor = 0;

  Position? get currentLocation => _currentLocation;
  LatLng? get targetLocation => _targetLocation;
  bool get isReached => _isReached;
  DoorElement? get targetDoor => _targetDoor;
  ClassElement? get targetClass => _targetClass;
  double get distance => _distance;
  //----------
  double get speed => _speed;
  double get altitude => _altitude;

  int get floor => _floor;

  LocationProvider() {
    LocationService.getStream().listen((Position? position) {
      _currentLocation = position;
      //----------
      _speed = position?.speed ?? -1;
      _floor = position!.floor ?? -1;
      _altitude = position.altitude ?? -1;

      if (_targetClass != null) {
        _targetDoor = LocationService.getClosestDoor(
            LatLng(currentLocation!.latitude, currentLocation!.longitude),
            _targetClass!.building.doors);

        _targetLocation = _targetDoor!.coordinates;

        _distance = LocationService.getDistanceGeometrical(
            LatLng(currentLocation!.latitude, currentLocation!.longitude),
            _targetLocation!);

        if (_distance <= 0.00012267717799377897) {
          _isReached = true;
        } else {
          _isReached = false;
        }
      }

      notifyListeners();
    });
  }

  void setNewTarget(ClassElement targetClass) async {
    _targetClass = targetClass;
    notifyListeners();
  }

  void cancelTarget() {
    _targetLocation = null;
    _isReached = false;
    _targetClass = null;
    _targetDoor = null;
    notifyListeners();
  }
}
