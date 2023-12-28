import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_map/models/building.dart';
import 'package:test_map/models/class.dart';
import 'package:test_map/models/door.dart';
import 'package:test_map/models/floor.dart';

class Lab implements IBuilding {
  @override
  int get floor_size => floors.length;

  @override
  List<FloorElement> get floors => [
        //FloorElement(index: 0, plan: Image.asset("assets/plans/lab/floor_1.jpg")),
        FloorElement(
            index: 0,
            plan: const AssetImage("assets/plans/lab/floor0_0.png"),
            classes: [
              ClassElement(name: "LB000"),
              ClassElement(name: "LB001"),
              ClassElement(name: "LB002"),
              ClassElement(name: "LB003"),
              ClassElement(name: "LB004"),
              ClassElement(name: "LB005"),
              ClassElement(name: "LB006"),
              ClassElement(name: "LB007"),
              ClassElement(name: "LB008"),
            ]),
        FloorElement(
            index: 1,
            plan: const AssetImage("assets/plans/lab/floor1.png"),
            classes: [
              ClassElement(name: "LB100"),
              ClassElement(name: "LB101"),
              ClassElement(name: "LB102"),
              ClassElement(name: "LB103"),
              ClassElement(name: "LB104"),
              ClassElement(name: "LB105"),
              ClassElement(name: "LB106"),
              ClassElement(name: "LB107"),
              ClassElement(name: "LB108"),
            ]),
      ];

  @override
  AssetImage get image => const AssetImage("assets/images/lab.png");

  @override
  @override
  String get name => "Lab";

  @override
  List<DoorElement> get doors => [
        DoorElement(
            id: "0",
            coordinates: const LatLng(38.740203, 35.475139),
            plan: const AssetImage("assets/plans/lab/floor0_0.png")),
      ];

  @override
  LatLng get location => const LatLng(38.740216, 35.475138);
}
