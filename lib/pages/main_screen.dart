import 'package:flutter/material.dart';
import 'package:test_map/pages/home_tab.dart';
import 'package:test_map/pages/map_tab.dart';
import 'package:test_map/pages/plans_tab.dart';
import 'package:test_map/resources/specifications.dart';
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
          appBar: AppBar(
            title: const Text(Strings.appName),
          ),
          extendBody: true,
          bottomNavigationBar: ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Specifications.radius, topRight: Specifications.radius),
            child: BottomAppBar(
                child: TabBar(
              indicatorColor: Colors.white,
              controller: _tabController,
              tabs: [
                Tab(icon: TabViews.home.getIcon()),
                Tab(icon: TabViews.map.getIcon()),
                Tab(icon: TabViews.plans.getIcon()),
              ],
            )),
          ),
          body: TabBarView(
              physics: const NeverScrollableScrollPhysics(), // Scroll ile dönmeyi kapatır
              controller: _tabController,
              children: [
                TabViews.home.getView(),
                TabViews.map.getView(),
                TabViews.plans.getView(),
              ]),
        ));
  }
}

enum TabViews {
  home,
  map,
  plans,
}

extension TabExtension on TabViews {
  Widget getView() {
    switch (name.toLowerCase()) {
      case "home":
        return const HomeTab();
      case "map":
        return const MapTab();
      case "plans":
        return const PlansTab();
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
      case "plans":
        return const Icon(Icons.place);
      default:
        return const Icon(Icons.error);
    }
  }
}
