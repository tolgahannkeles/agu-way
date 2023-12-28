import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_map/models/building.dart';
import 'package:test_map/models/class.dart';
import 'package:test_map/models/door.dart';
import 'package:test_map/models/floor.dart';

class WareHouse implements IBuilding {
  @override
  AssetImage get image => const AssetImage("assets/images/warehouse.png");

  @override
  get location => const LatLng(38.737042, 35.474362);

  @override
  int get floor_size => floors.length;

  @override
  List<FloorElement> get floors => [
        FloorElement(
          index: 0,
          plan: const AssetImage("assets/plans/warehouse/floor0_0.png"),
          classes: [
            ClassElement(name: "BA001"),
            ClassElement(name: "BA002"),
            ClassElement(name: "BA003"),
            ClassElement(name: "BA004"),
            ClassElement(name: "BA005"),
            ClassElement(name: "BA006"),
            ClassElement(name: "BA007"),
            ClassElement(name: "BA008"),
            ClassElement(name: "BA009"),
          ],
        ),
        FloorElement(
            index: 1,
            plan: const AssetImage("assets/plans/warehouse/floor1.png"),
            classes: [
              ClassElement(name: "BA100"),
              ClassElement(name: "BA101"),
              ClassElement(name: "BA102"),
              ClassElement(name: "BA103"),
              ClassElement(name: "BA104"),
              ClassElement(name: "BA105"),
              ClassElement(name: "BA106"),
              ClassElement(name: "BA107"),
            ])
      ];

  @override
  String get name => "Warehouse";

  @override
  List<DoorElement> get doors => [
        DoorElement(
            id: "1",
            coordinates: const LatLng(38.737471, 35.474131),
            plan: const AssetImage("assets/plans/warehouse/floor0_0.png")),
        DoorElement(
            id: "2",
            coordinates: const LatLng(38.737033, 35.474384),
            plan: const AssetImage("assets/plans/warehouse/floor0_1.png")),
        DoorElement(
            id: "3",
            coordinates: const LatLng(38.737201, 35.473742),
            plan: const AssetImage("assets/plans/warehouse/floor0_2.png")),
        DoorElement(
            id: "4",
            coordinates: const LatLng(38.736908, 35.473910),
            plan: const AssetImage("assets/plans/warehouse/floor0_3.png")),
        DoorElement(
            id: "5",
            coordinates: const LatLng(38.736498, 35.474448),
            plan: const AssetImage("assets/plans/warehouse/floor0_4.png")),
      ];
}
