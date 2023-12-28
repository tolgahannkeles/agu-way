import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:test_map/models/floor.dart';

class FloorPlanView extends StatelessWidget {
  FloorPlanView({super.key, required this.floor});
  FloorElement floor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .80,
            child: PhotoView(
              imageProvider: floor.plan,
              enablePanAlways: true,
            ),
          ),
        ],
      ),
    );
  }
}
