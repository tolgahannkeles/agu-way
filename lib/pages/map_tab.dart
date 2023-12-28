import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_map/pages/map_view.dart';
import 'package:test_map/services/LocationProvider.dart';
import 'package:test_map/ui/FindClassField.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> with RouteAware {
  LocationProvider? locationProvider;

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);

    return Stack(
      children: [
        const MapView(),
        FindClassField(
          onFound: (targetClass) {
            locationProvider?.setNewTarget(targetClass);
          },
        ),
      ],
    );
  }
}
