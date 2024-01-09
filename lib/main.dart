import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:test_map/pages/main_screen.dart';

import 'package:test_map/resources/colors.dart';
import 'package:test_map/services/LocationProvider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp,DeviceOrientation.portraitDown]);

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

            listTileTheme: ListTileThemeData(
              iconColor: PageColors.aguWhite,
              textColor: PageColors.aguWhite,
            ),
            appBarTheme:
                AppBarTheme(centerTitle: true, backgroundColor: PageColors.aguColor, systemOverlayStyle: SystemUiOverlayStyle.dark.copyWith(statusBarColor: PageColors.aguColor, statusBarIconBrightness: Brightness.light)),
            drawerTheme: DrawerThemeData(backgroundColor: PageColors.aguColor),
            bottomAppBarTheme: BottomAppBarTheme(color: PageColors.aguColor),
            tabBarTheme: const TabBarTheme(
              indicatorColor: Colors.white,
            )),
        debugShowCheckedModeBanner: false,
        home: const MainScreen(),
      ),
    );
  }
}
