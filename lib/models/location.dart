import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel {
  String roomName;
  Buildings building;
  String assetName;

  LocationModel(
      {required this.roomName, required this.building, required this.assetName});
}

enum Buildings {
  steel,
  warehouse,
  lab,
  factory,
}

extension BuildingExtension on Buildings {
  LatLng getLocation() {
    switch (name) {
      case "steel":
        return const LatLng(38.737110, 35.473559);
      case "warehouse":
        return const LatLng(38.737042, 35.474362);
      case "lab":
        return const LatLng(38.740216, 35.475138);
      case "factory":
        return const LatLng(38.738845, 35.474455);
      default:
        return const LatLng(0, 0);
    }
  }
}
