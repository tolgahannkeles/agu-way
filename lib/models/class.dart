import 'package:test_map/data/buildings/lab.dart';
import 'package:test_map/data/buildings/steel.dart';
import 'package:test_map/data/buildings/warehouse.dart';
import 'package:test_map/models/building.dart';

class ClassElement {
  late IBuilding building;
  late int floorNo;
  late String classId;
  String name;
  ClassElement({required this.name}) {
    divideParts(name);
  }

  void divideParts(String name) {
    name = name.toUpperCase();
    if (name.startsWith("BA")) {
      building = WareHouse();
      floorNo = int.parse(name[2]);
      classId = name.substring(2, name.length);
    } else if (name.startsWith("B")) {
      building = Steel();
      floorNo = int.parse(name[1]);
      classId = name.substring(1, name.length);
    } else if (name.startsWith("A")) {
      building = Steel();
      floorNo = int.parse(name[1]);
      classId = name.substring(1, name.length);
    } else if (name.startsWith("LB")) {
      building = Lab();
      floorNo = int.parse(name[2]);
      classId = name.substring(2, name.length);
    } else {
      //invalid
    }
  }
}
