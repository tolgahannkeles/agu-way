import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_map/data/buildings/lab.dart';
import 'package:test_map/data/buildings/steel.dart';
import 'package:test_map/data/buildings/warehouse.dart';
import 'package:test_map/models/door.dart';
import 'package:test_map/models/floor.dart';

enum Buildings {
  steel,
  warehouse,
  lab,
}

extension BuildingExtension on Buildings {
  IBuilding getBuilding() {
    switch (this) {
      case Buildings.steel:
        return Steel();
      case Buildings.lab:
        return Lab();
      case Buildings.warehouse:
        return WareHouse();
      default:
        return Steel();
    }
  }
}

abstract class IBuilding {
  String get name;
  List<DoorElement> get doors;
  AssetImage get image;
  int get floor_size;
  List<FloorElement> get floors;
  LatLng get location;
}
