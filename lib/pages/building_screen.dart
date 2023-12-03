import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:test_map/services/LinePainter.dart';

class BuildingScreen extends StatefulWidget {
  const BuildingScreen({Key? key}) : super(key: key);

  @override
  State<BuildingScreen> createState() => _BuildingScreenState();
}

class _BuildingScreenState extends State<BuildingScreen> {
  @override
  Widget build(BuildContext context) {
    var image = Image.asset(
      "assets/images/kroki.png",
      fit: BoxFit.cover,
    );
    var ratio = ((image.height ?? 0) / (image.width ?? 1));

    return Scaffold(
      appBar: AppBar(
        title: Text("Building Screen"),
      ),
      body: normalView(),
    );
  }
}

class normalView extends StatelessWidget {
  const normalView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PhotoView(
          imageProvider: AssetImage("assets/images/kroki.png"),
          enablePanAlways: true,
        ),
        CustomPaint(
          painter: LinePainter(Offset(100, 50), Offset(100, 250)),
        ),
      ],
    );
  }
}
