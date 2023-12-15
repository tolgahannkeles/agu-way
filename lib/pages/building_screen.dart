import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:test_map/services/LinePainter.dart';

class BuildingScreen extends StatelessWidget {
  const BuildingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Building Screen"),
      ),
      body: const NormalView(),
    );
  }
}

class NormalView extends StatelessWidget {
  const NormalView({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoView(
          imageProvider: const AssetImage("assets/images/kroki.png"),
          enablePanAlways: true,
        ),
        CustomPaint(
          painter: LinePainter(const Offset(100, 50), const Offset(100, 250)),
        ),
      ],
    );
  }
}
