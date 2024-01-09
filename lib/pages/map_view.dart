import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:test_map/map_api.dart';
import 'package:test_map/pages/plan_screen.dart';
import 'package:test_map/resources/colors.dart';
import 'package:test_map/resources/specifications.dart';
import 'package:test_map/services/LocationProvider.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapView extends StatefulWidget {
  const MapView({super.key});
  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  BitmapDescriptor currentPin = Specifications.currentLocationPin;
  BitmapDescriptor targetPin = Specifications.targetLocationPin;
  TravelMode travelMode = TravelMode.walking;

  double? currentLatitude;
  double? currentLongitude;
  double? targetLatitude;
  double? targetLongitude;
  LatLng defaultLocation = const LatLng(38.74074685584025, 35.47471327184061);

  Map<MarkerId, Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  final Completer<GoogleMapController> _controller = Completer();

  late LocationProvider locationProvider;

  static const CameraPosition _initialMap = CameraPosition(
    target: LatLng(38.73742088739644, 35.475462278658),
    zoom: 16.2046,
    bearing: -20,
    tilt: 0,
  );
  bool _isPlanOpened = false;

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    targetLatitude = locationProvider.targetLocation?.latitude;
    targetLongitude = locationProvider.targetLocation?.longitude;
    currentLatitude = locationProvider.currentLocation?.latitude;
    currentLongitude = locationProvider.currentLocation?.longitude;

    _addMarker(
      LatLng(currentLatitude ?? defaultLocation.latitude,
          currentLongitude ?? defaultLocation.longitude),
      "current",
      currentPin,
    );

    if (targetLongitude != null && targetLatitude != null) {
      _addMarker(
        LatLng(targetLatitude!, targetLongitude!),
        "target",
        targetPin,
      );
      getPolyline();
    }

    if (locationProvider.isReached) {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        if (!_isPlanOpened) {
          bool? response = await Navigator.of(context).push<bool>(
            MaterialPageRoute(
                builder: (context) {
                  _isPlanOpened = true;
                  return PlanScreen(
                    targetClass: locationProvider.targetClass!,
                    targetDoor: locationProvider.targetDoor!,
                  );
                },
                settings: const RouteSettings(),
                fullscreenDialog: true),
          );

          if (response == false) {
            _isPlanOpened = false;
          }
        }
      });
    }

    return SafeArea(
      child: GoogleMap(
        initialCameraPosition: _initialMap,
        mapType: MapType.hybrid,
        compassEnabled: false,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
        indoorViewEnabled: false,
        liteModeEnabled: false,
        mapToolbarEnabled: false,
        buildingsEnabled: false,
        trafficEnabled: false,
        fortyFiveDegreeImageryEnabled: false,
        polylines: Set<Polyline>.of(polylines.values),
        markers: Set<Marker>.of(markers.values),
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }

  void _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(
      markerId: markerId,
      icon: descriptor,
      position: position,
    );
    markers[markerId] = marker;
  }

  void _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("polylines");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 8,
      color: PageColors.pathColor,
    );
    if (mounted) {
      setState(() {
        polylines[id] = polyline;
      });
    }
  }

  Future<void> getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      maps_api,
      PointLatLng(currentLatitude ?? defaultLocation.latitude,
          currentLongitude ?? defaultLocation.longitude),
      PointLatLng(targetLatitude!, targetLongitude!),
      travelMode: travelMode,
    );
    if (result.points.isNotEmpty) {
      polylineCoordinates =
          result.points.map((point) => LatLng(point.latitude, point.longitude)).toList();
    } else {}
    _addPolyLine(polylineCoordinates);
  }
}
