import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_map/pages/map_view.dart';
import 'package:test_map/resources/specifications.dart';
import 'package:test_map/services/LocationProvider.dart';
import 'package:test_map/ui/FindClassField.dart';

class MapTab extends StatefulWidget {
  const MapTab({super.key});

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> with RouteAware {
  late LocationProvider locationProvider;

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);

    return Stack(
      children: [
        const MapView(),
        FindClassField(
          onFound: (targetClass) {
            locationProvider.setNewTarget(targetClass);
          },
        ),
        Positioned(
            top: 60,
            right: 20,
            child: Column(
              children: [
                Text(
                  "Distance: ${locationProvider.distance}",
                  style: Specifications.titleStyle
                      .copyWith(color: Colors.green, backgroundColor: Colors.white),
                ),
                Text(
                  "Speed: ${locationProvider.speed}",
                  style: Specifications.titleStyle
                      .copyWith(color: Colors.green, backgroundColor: Colors.white),
                ),
                Text(
                  "Floor: ${locationProvider.floor}",
                  style: Specifications.titleStyle
                      .copyWith(color: Colors.green, backgroundColor: Colors.white),
                ),
                Text(
                  "Altitude: ${locationProvider.altitude}",
                  style: Specifications.titleStyle
                      .copyWith(color: Colors.green, backgroundColor: Colors.white),
                ),
              ],
            ))
      ],
    );
  }
}
