import 'package:flutter/material.dart';
import 'package:test_map/pages/main_screen.dart';
import 'package:test_map/pages/map_screen.dart';

import 'package:test_map/pages/map_tab.dart';
import 'package:test_map/pages/map_view.dart';
import 'package:test_map/pages/search.dart';
import 'package:test_map/resources/colors.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(centerTitle: true, backgroundColor: PageColors.aguColor),
        drawerTheme: DrawerThemeData(backgroundColor: PageColors.aguColor),
        bottomAppBarTheme: BottomAppBarTheme(color: PageColors.aguColor),
      ),
      debugShowCheckedModeBanner: false,
      home: const MapScreen(),
    );
  }
}
