import 'package:flutter/material.dart';
import 'package:test_map/models/class.dart';

class FloorElement {
  AssetImage plan;
  Floor floor;
  int index;
  List<ClassElement> classes = [];
  FloorElement(
      {required this.index,
      required this.plan,
      required this.classes,
      required this.floor});
}

enum Floor {
  ground,
  first,
  second,
}
