import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class PlanScreen extends StatelessWidget {
  const PlanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: PhotoView(
        imageProvider: const AssetImage("assets/images/kroki.png"),
        enablePanAlways: true,
      ),
    );
  }
}
