import 'dart:async';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:provider/provider.dart';
import 'package:test_map/models/class.dart';
import 'package:test_map/models/door.dart';
import 'package:test_map/resources/colors.dart';
import 'package:test_map/services/LocationProvider.dart';

// ignore: must_be_immutable
class PlanScreen extends StatefulWidget {
  ClassElement targetClass;
  DoorElement targetDoor;
  PlanScreen({super.key, required this.targetDoor, required this.targetClass});

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late LocationProvider locationProvider;
  late ClassElement _targetClass;
  late AssetImage _plan;
  late Widget question;

  Timer? _timer;

  @override
  void initState() {
    _plan = widget.targetDoor.plan;
    _targetClass = widget.targetClass;

    if (_targetClass.floorNo != 0) {
      showYesNoDialog();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    question = Text(_targetClass.name);

    return Scaffold(
      appBar: AppBar(
          leading: IconButton(
              onPressed: () {
                locationProvider.cancelTarget();
                Navigator.of(context).pop<bool>(false);
              },
              icon: const Icon(Icons.arrow_back))),
      body: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * .80,
            child: PhotoView(
              //imageProvider: const AssetImage("assets/images/kroki.png"),
              imageProvider: _plan,
              enablePanAlways: true,
            ),
          ),
        ],
      ),
    );
  }

  void showYesNoDialog() {
    _timer = Timer(const Duration(seconds: 10), () {
      setState(() {
        showDialog(
          barrierDismissible: false,
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: PageColors.aguColor,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              titleTextStyle: TextStyle(color: PageColors.aguWhite),
              title: const Text('Did you come to the stair?'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    showYesNoDialog();
                  },
                  child: Text(
                    'No',
                    style: TextStyle(color: PageColors.aguWhite),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    setState(() {
                      _plan = _targetClass.building.floors[_targetClass.floorNo].plan;
                      Navigator.of(context).pop();
                    });
                  },
                  child: Text(
                    'Yes',
                    style: TextStyle(color: PageColors.aguWhite),
                  ),
                ),
              ],
            );
          },
        );
      });
    });
  }

  @override
  void dispose() {
    if (_timer != null) {
      _timer?.cancel();
    }
    super.dispose();
  }
}
