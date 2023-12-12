import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_map/map_api.dart';
import 'package:test_map/services/LocationService.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class MapView extends StatefulWidget {
  MapView({super.key, this.longitude, this.latitude});
  double? longitude;
  double? latitude;

  @override
  State<MapView> createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  double? latitude;
  double? longitude;
  double? targetLatitude;
  double? targetLongitude;
  LatLng defaultLocation = const LatLng(38.74074685584025, 35.47471327184061);

  Map<MarkerId, Marker> markers = {};
  PolylinePoints polylinePoints = PolylinePoints();
  Map<PolylineId, Polyline> polylines = {};
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _initialMap = CameraPosition(
      target: LatLng(38.73742088739644, 35.475462278658),
      zoom: 16.2046,
      bearing: -20,
      tilt: 0);

  @override
  void initState() {
    targetLatitude = widget.latitude;
    targetLongitude = widget.longitude;

    LocationService.getStream().listen((Position? position) {
      if (mounted) {
        setState(() {
          latitude = position?.latitude;
          longitude = position?.longitude;

          print(latitude);

          _addMarker(
            LatLng(latitude ?? defaultLocation.latitude,
                longitude ?? defaultLocation.longitude),
            "current",
            BitmapDescriptor.defaultMarkerWithHue(90),
          );

          if (targetLongitude == null || targetLatitude == null) {
          } else {
            _addMarker(
              LatLng(targetLatitude!, targetLongitude!),
              "destination",
              BitmapDescriptor.defaultMarker,
            );

            getPolyline();
          }
        });
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _initialMap,
      mapType: MapType.satellite,
      zoomControlsEnabled: false,
      compassEnabled: false,
      polylines: Set<Polyline>.of(polylines.values),
      markers: Set<Marker>.of(markers.values),
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  _addMarker(LatLng position, String id, BitmapDescriptor descriptor) {
    MarkerId markerId = MarkerId(id);
    Marker marker = Marker(markerId: markerId, icon: descriptor, position: position);
    markers[markerId] = marker;
  }

  _addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      points: polylineCoordinates,
      width: 8,
      color: Colors.pink,
    );
    if (mounted) {
      setState(() {
        polylines[id] = polyline;
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      maps_api,
      PointLatLng(
          latitude ?? defaultLocation.latitude, longitude ?? defaultLocation.longitude),
      PointLatLng(targetLatitude!, targetLongitude!),
      travelMode: TravelMode.walking,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      print(result.errorMessage);
    }
    _addPolyLine(polylineCoordinates);
  }
}
