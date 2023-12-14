import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class TestScreen extends StatelessWidget {
  final LatLng destinationCoordinates; // Elde ettiğiniz hedef koordinatları

  TestScreen(this.destinationCoordinates);

  Future<void> openMaps() async {
    String url =
        'https://www.google.com/maps/dir/?api=1&destination=${destinationCoordinates.latitude},${destinationCoordinates.longitude}';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Haritalar'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: openMaps,
          child: Text('Yol Tarifi Al'),
        ),
      ),
    );
  }
}
