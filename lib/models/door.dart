import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DoorElement {
  String id;
  LatLng coordinates;
  AssetImage plan;
  DoorElement({required this.id, required this.coordinates, required this.plan});
}
