import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:test_map/models/floor.dart';

class FloorPlanView extends StatelessWidget {
  FloorPlanView({super.key, required this.floor});
  FloorElement floor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: InteractiveViewer(
          panEnabled: true,
          child: Image.asset(
            floor.plan.assetName,
          ),
        ),
      ),
    );
  }
}
