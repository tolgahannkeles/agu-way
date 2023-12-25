import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

class FloorElement {
  var plan;
  int index;
  List<ClassElement> classes = [];
  FloorElement({required this.index, required this.plan, required this.classes});
}

class ClassElement {
  String name;
  ClassElement({
    required this.name,
  });
}

abstract class IBuilding {
  String get name;
  List<LatLng> get doors;
  NetworkImage get image;
  int get floor_size;
  List<FloorElement> get floors;
  LatLng get location;
}

class Lab implements IBuilding {
  @override
  int get floor_size => floors.length;

  @override
  List<FloorElement> get floors => [
        //FloorElement(index: 0, plan: Image.asset("assets/plans/lab/floor_1.jpg")),
        FloorElement(
            index: 0,
            plan: const NetworkImage(
                "https://seeklogo.com/images/A/abdullah-gul-universitesi-logo-50B4B48AD4-seeklogo.com.png"),
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
        FloorElement(
            index: 1,
            plan: const NetworkImage(
                "https://seeklogo.com/images/A/abdullah-gul-universitesi-logo-50B4B48AD4-seeklogo.com.png"),
            classes: [
              ClassElement(name: "LB200"),
              ClassElement(name: "LB201"),
              ClassElement(name: "LB202"),
              ClassElement(name: "LB203"),
              ClassElement(name: "LB204"),
              ClassElement(name: "LB205"),
              ClassElement(name: "LB206"),
              ClassElement(name: "LB207"),
            ]),
      ];

  @override
  NetworkImage get image => const NetworkImage(
      "https://www.veritastr.com/images/uploads/tk_022A6116-C487-4AE0-1A3D-6601D5D258F8.jpg");

  @override
  @override
  String get name => "Lab";

  @override
  List<LatLng> get doors => [
        const LatLng(38.740216, 35.475138),
      ];

  @override
  // TODO: implement location
  LatLng get location => const LatLng(38.740216, 35.475138);
}

class WareHouse implements IBuilding {
  @override
  NetworkImage get image => const NetworkImage(
      "https://www.arkitera.com/wp-content/uploads/2017/01/AG%C3%9C-S%C3%BCmer-Kamp%C3%BCs%C3%BC-B%C3%BCy%C3%BCk-Ambar-Binas%C4%B1-Restorasyon-Projesi-18-615x375.jpg");

  @override
  get location => const LatLng(38.737042, 35.474362);

  @override
  int get floor_size => floors.length;

  @override
  List<FloorElement> get floors => [
        FloorElement(
          index: 0,
          plan: const NetworkImage(
              "https://seeklogo.com/images/A/abdullah-gul-universitesi-logo-50B4B48AD4-seeklogo.com.png"),
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
            plan: const NetworkImage(
                "https://seeklogo.com/images/A/abdullah-gul-universitesi-logo-50B4B48AD4-seeklogo.com.png"),
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
  // TODO: implement name
  String get name => "Warehouse";

  @override
  // TODO: implement doors
  List<LatLng> get doors => throw UnimplementedError();
}

class Steel implements IBuilding {
  @override
  NetworkImage get image => const NetworkImage(
        "https://images.divisare.com/images/c_limit,f_auto,h_2000,q_auto,w_3000/v1494235636/bhubfukr0ufbyxahr3ka/eaa-emre-arolat-architecture-cemal-emden-studio-majo-agu-sumer-campus.jpg",
      );

  @override
  get location => const LatLng(38.737110, 35.473559);

  @override
  int get floor_size => floors.length;

  @override
  List<FloorElement> get floors => [
        FloorElement(
            index: 0,
            plan: const NetworkImage(
                "https://seeklogo.com/images/A/abdullah-gul-universitesi-logo-50B4B48AD4-seeklogo.com.png"),
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
            plan: const NetworkImage(
                "https://seeklogo.com/images/A/abdullah-gul-universitesi-logo-50B4B48AD4-seeklogo.com.png"),
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
        FloorElement(
            index: 2,
            plan: const NetworkImage(
                "https://seeklogo.com/images/A/abdullah-gul-universitesi-logo-50B4B48AD4-seeklogo.com.png"),
            classes: [
              ClassElement(name: "B200"),
              ClassElement(name: "B201"),
              ClassElement(name: "B202"),
              ClassElement(name: "B203"),
              ClassElement(name: "B204"),
              ClassElement(name: "B205"),
              ClassElement(name: "B206"),
              ClassElement(name: "B207"),
              ClassElement(name: "B208"),
              ClassElement(name: "B209"),
              ClassElement(name: "B210"),
              ClassElement(name: "B211"),
              ClassElement(name: "B212"),
              ClassElement(name: "B213"),
              ClassElement(name: "B214"),
              ClassElement(name: "B215"),
            ]),
      ];

  @override
  // TODO: implement name
  String get name => "Steel";

  @override
  // TODO: implement doors
  List<LatLng> get doors => throw UnimplementedError();
}
