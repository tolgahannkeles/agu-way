import 'package:flutter/material.dart';
import 'package:test_map/pages/home_page.dart';
import 'package:test_map/pages/new_mapView.dart';
import 'package:test_map/resources/strings.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with TickerProviderStateMixin {
  late final TabController _tabController =
      TabController(length: TabViews.values.length, vsync: this);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: TabViews.values.length,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          drawer: Drawer(),
          appBar: AppBar(
            title: const Text(Strings.appName),
          ),
          extendBody: true,
          bottomNavigationBar: ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10), topRight: Radius.circular(10)),
            child: BottomAppBar(
                child: TabBar(
              indicatorColor: Colors.white,
              controller: _tabController,
              tabs: [
                Tab(icon: TabViews.home.getIcon()),
                Tab(icon: TabViews.map.getIcon()),
                Tab(icon: TabViews.settings.getIcon()),
              ],
            )),
          ),
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(), // Scroll ile dönmeyi kapatır
              controller: _tabController,
              children: [
                TabViews.home.getView(),
                TabViews.map.getView(),
                TabViews.settings.getView(),
              ]),
        ));
  }
}

enum TabViews {
  home,
  map,
  settings,
}

extension TabExtension on TabViews {
  Widget getView() {
    switch (name.toLowerCase()) {
      case "home":
        return const HomeScreen();
      case "map":
        return NewMapView();
      case "settings":
        return const Placeholder();
      default:
        return const Placeholder();
    }
  }

  Icon getIcon() {
    switch (name.toLowerCase()) {
      case "home":
        return const Icon(Icons.home_rounded);
      case "map":
        return const Icon(Icons.map_outlined);
      case "settings":
        return const Icon(Icons.settings);
      default:
        return const Icon(Icons.error);
    }
  }
}
