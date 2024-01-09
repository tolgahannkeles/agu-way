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
            floor: Floor.ground,
            plan: const AssetImage("assets/plans/lab/floor0.png"),
            classes: [
              ClassElement(name: "LB101"),
              ClassElement(name: "LB102"),
              ClassElement(name: "LB103"),
              ClassElement(name: "LB104"),
              ClassElement(name: "LB105"),
              ClassElement(name: "LB106"),
              ClassElement(name: "LB107"),
              ClassElement(name: "LB108"),
              ClassElement(name: "LB109"),
              ClassElement(name: "LB110"),
              ClassElement(name: "LB111"),
            ]),
        FloorElement(
            index: 1,
            floor: Floor.first,
            plan: const AssetImage("assets/plans/lab/floor1.png"),
            classes: [
              ClassElement(name: "LB201"),
              ClassElement(name: "LB202"),
              ClassElement(name: "LB203"),
              ClassElement(name: "LB204"),
              ClassElement(name: "LB205"),
              ClassElement(name: "LB206"),
              ClassElement(name: "LB207"),
              ClassElement(name: "LB208"),
              ClassElement(name: "LB209"),
              ClassElement(name: "LB210"),
              ClassElement(name: "LB211"),
              ClassElement(name: "LB212"),
              ClassElement(name: "LB213"),
              ClassElement(name: "LB214"),
              ClassElement(name: "LB215"),
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
