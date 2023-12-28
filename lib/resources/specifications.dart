import 'package:flutter/material.dart';
import 'package:test_map/resources/colors.dart';

class Specifications {
  static BorderRadius borderRadius = BorderRadius.circular(15);
  static Radius radius = const Radius.circular(15);
  static EdgeInsets padding_all = const EdgeInsets.all(15);
  static EdgeInsets padding_horizontal = const EdgeInsets.symmetric(horizontal: 15);
  static EdgeInsets padding_only_bottom = const EdgeInsets.only(bottom: 15);
  static EdgeInsets padding_only_left = const EdgeInsets.only(left: 15);

  static TextStyle titleStyle =
      TextStyle(fontWeight: FontWeight.bold, color: PageColors.aguWhite, fontSize: 24);
}
