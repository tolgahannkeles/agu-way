import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_map/pages/main_screen.dart';

import 'package:test_map/resources/colors.dart';
import 'package:test_map/services/LocationProvider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: LocationProvider(),
        )
      ],
      child: MaterialApp(
        theme: ThemeData(
          appBarTheme:
              AppBarTheme(centerTitle: true, backgroundColor: PageColors.aguColor),
          drawerTheme: DrawerThemeData(backgroundColor: PageColors.aguColor),
          bottomAppBarTheme: BottomAppBarTheme(color: PageColors.aguColor),
        ),
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
      ),
    );
  }
}
