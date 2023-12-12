import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:test_map/data/location_data.dart';
import 'package:test_map/map_api.dart';
import 'package:test_map/models/location.dart';
import 'package:test_map/pages/building_screen.dart';
import 'package:test_map/resources/colors.dart';
import 'package:test_map/services/LocationService.dart';

class NewMapView extends StatefulWidget {
  NewMapView({super.key});

  @override
  _NewMapViewState createState() => _NewMapViewState();
}

class _NewMapViewState extends State<NewMapView> {
  final TextEditingController _searchController = TextEditingController();
  List<LocationModel> originalList = DummyData.locations;
  List<LocationModel> filteredList = [];

  void _filterList(String searchText) {
    setState(() {
      filteredList = originalList
          .where(
              (item) => item.roomName.toLowerCase().startsWith(searchText.toLowerCase()))
          .toList();
    });
  }

  void _updateMapView(double latitude, double longitude) {
    _changeLoading();
    setState(() {
      targetLatitude = latitude;
      targetLongitude = longitude;
    });
  }

  bool _isLoading = false;
  void _changeLoading() {
    _isLoading = !_isLoading;
  }

  Column _searchBox() {
    return Column(
      children: [
        TextField(
          controller: _searchController,
          onChanged: (value) {
            _filterList(value);
          },
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            prefixIcon: const Icon(Icons.search_outlined),
            prefixIconColor: PageColors.aguWhite,
            hintText: 'Enter text...',
            fillColor: PageColors.aguColor,
            hintStyle: TextStyle(color: PageColors.aguWhite, fontWeight: FontWeight.bold),
            filled: true,
            suffixIcon: _isLoading
                ? Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: CircularProgressIndicator(
                      color: PageColors.aguWhite,
                    ),
                  )
                : null,
            suffixIconColor: PageColors.aguWhite,
          ),
        ),
        SizedBox(
          height: filteredList.length > 4
              ? MediaQuery.of(context).size.height * .25
              : filteredList.length * 50,
          child: ListView.builder(
            itemCount: filteredList.length,
            addRepaintBoundaries: false,
            itemBuilder: (context, index) {
              return _searchItem(index);
            },
          ),
        ),
      ],
    );
  }

  void _clearFilters() {
    setState(() {
      filteredList.clear();
      _searchController.clear();
    });
  }

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
    LocationService.getStream().listen((Position? position) {
      setState(() {
        latitude = position?.latitude;
        longitude = position?.longitude;
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

      if (_isUserInTarget()) {
        Navigator.of(context).push(
          MaterialPageRoute(
              builder: (context) {
                return const BuildingScreen();
              },
              settings: const RouteSettings(),
              fullscreenDialog: true),
        );
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _mapView(),
        _searchBox(),
      ],
    );
  }

  Widget _mapView() {
    return GoogleMap(
      initialCameraPosition: _initialMap,
      mapType: MapType.satellite,
      zoomControlsEnabled: false,
      compassEnabled: false,
      buildingsEnabled: true,
      indoorViewEnabled: true,
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
    setState(() {
      polylines[id] = polyline;
    });
  }

  void getPolyline() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      maps_api,
      PointLatLng(
          latitude ?? defaultLocation.latitude, longitude ?? defaultLocation.longitude),
      PointLatLng(targetLatitude!, targetLongitude!),
      travelMode: TravelMode.walking,
      avoidFerries: true,
      avoidHighways: true,
      avoidTolls: true,
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

  Widget _searchItem(int index) {
    return Padding(
      padding: const EdgeInsets.only(left: 50, right: 70),
      child: InkWell(
        onTap: () {
          LatLng latLng = filteredList[index].building.getLocation();
          _updateMapView(latLng.latitude, latLng.longitude);

          _clearFilters();
        },
        child: SizedBox(
          height: 50,
          child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: PageColors.aguColor,
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 20.0),
                    child: Icon(Icons.home),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(filteredList[index].roomName),
                  ),
                ],
              )),
        ),
      ),
    );
  }

  bool _isUserInTarget() {
    double distance = calculateDistance(
        latitude ?? defaultLocation.latitude,
        longitude ?? defaultLocation.longitude,
        targetLatitude ?? defaultLocation.latitude,
        targetLongitude ?? defaultLocation.longitude);

    if (distance < 40) {
      return true;
    } else {
      return false;
    }
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    // calculate metres between two points
    // There is a problem with that function
    // TODO test it
    const R = 6371000.0; // Earth radius in meters

    double toRadians(double degree) {
      return degree * (pi / 180.0);
    }

    var phi1 = toRadians(lat1);
    var phi2 = toRadians(lat2);
    var deltaPhi = toRadians(lat2 - lat1);
    var deltaLambda = toRadians(lon2 - lon1);

    var a = sin(deltaPhi / 2) * sin(deltaPhi / 2) +
        cos(phi1) * cos(phi2) * sin(deltaLambda / 2) * sin(deltaLambda / 2);

    var c = 2 * atan2(sqrt(a), sqrt(1 - a));

    var distance = R * c;
    // return distance;
    return 100;
  }
}
