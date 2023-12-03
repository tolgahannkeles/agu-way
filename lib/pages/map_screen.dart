import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_map/map_api.dart';
import 'package:test_map/pages/building_screen.dart';
import 'package:test_map/services/LocationService.dart';

/*
tilt --> yerden açı
bearing --> bakış yönü
*/

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();

  double? latitude;
  double? longitude;

  static const LatLng finish_point = LatLng(32423, 23423);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    LocationService.getStream().listen((Position? position) {
      setState(() {
        latitude = position?.latitude;
        longitude = position?.longitude;

        if (longitude == finish_point.longitude && latitude == finish_point.latitude) {
          _openBuildingScreen();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        mapType: MapType.satellite,
        initialCameraPosition: _initialAGU,
        markers: {
          _SpecialMarker.lab_building.getMarker(),
          Marker(
              markerId: const MarkerId("current"),
              icon: BitmapDescriptor.defaultMarker,
              position:
                  LatLng(latitude ?? 38.74074685584025, longitude ?? 35.47471327184061)),
        },
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
          icon: const Icon(Icons.location_on_outlined),
          label: const Text("Get Current"),
          onPressed: () {
            _openBuildingScreen();
          }),
    );
  }

  Future<void> _goToCurrent() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(
      CameraPosition(
        target: LatLng(latitude ?? 38.74074685584025, longitude ?? 35.47471327184061),
        zoom: 15,
      ),
    ));
  }

  static const CameraPosition _initialAGU = CameraPosition(
      target: LatLng(38.73742088739644, 35.475462278658),
      zoom: 16.2046,
      bearing: -20, // bakış yönü
      tilt: 0);

  void _openBuildingScreen() {
    Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return BuildingScreen();
        },
        fullscreenDialog: true));
  }
}

enum _SpecialMarker {
  lab_building,
}

extension _SpecialMarkerExtension on _SpecialMarker {
  Marker getMarker() {
    if (this == _SpecialMarker.lab_building.name) {
      return Marker(
          markerId: MarkerId(_SpecialMarker.lab_building.name),
          icon: BitmapDescriptor.defaultMarker,
          position: const LatLng(38.74074685584025, 35.47471327184061));
    }

    return const Marker(markerId: MarkerId("null"));
  }
}
