import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_map/models/building.dart';
import 'package:test_map/models/class.dart';
import 'package:test_map/models/door.dart';
import 'package:test_map/models/floor.dart';

class Steel implements IBuilding {
  @override
  AssetImage get image => const AssetImage("assets/images/steel.png");

  @override
  get location => const LatLng(38.737110, 35.473559);

  @override
  int get floor_size => floors.length;

  @override
  List<FloorElement> get floors => [
        FloorElement(
            index: 0,
            floor: Floor.ground,
            plan: const AssetImage("assets/plans/steel/floor0.png"),
            classes: [
              ClassElement(name: "B000"),
              ClassElement(name: "B001"),
              ClassElement(name: "B002"),
              ClassElement(name: "B003"),
              ClassElement(name: "B004"),
              ClassElement(name: "B005"),
              ClassElement(name: "B006"),
            ]),
        FloorElement(
            index: 1,
            floor: Floor.first,
            plan: const AssetImage("assets/plans/steel/floor1.png"),
            classes: [
              ClassElement(name: "B100"),
              ClassElement(name: "B101"),
              ClassElement(name: "B102"),
              ClassElement(name: "B103"),
              ClassElement(name: "B104"),
              ClassElement(name: "B105"),
              ClassElement(name: "B106"),
              ClassElement(name: "B107"),
            ]),
      ];

  @override
  String get name => "Steel";

  @override
  List<DoorElement> get doors => [
        DoorElement(
            id: "1",
            coordinates: const LatLng(38.737055, 35.473510), //A
            plan: const AssetImage("assets/plans/steel/floor0_0.png")),
        DoorElement(
            id: "2",
            coordinates: const LatLng(38.736869, 35.473821), //B
            plan: const AssetImage("assets/plans/steel/floor0_1.png")),
        DoorElement(
            id: "3",
            coordinates: const LatLng(38.736318, 35.473916), //C
            plan: const AssetImage("assets/plans/steel/floor0_2.png")),
      ];
}
