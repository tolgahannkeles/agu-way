import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_map/models/building.dart';
import 'package:test_map/models/class.dart';
import 'package:test_map/pages/map_tab.dart';
import 'package:test_map/resources/colors.dart';
import 'package:test_map/resources/specifications.dart';
import 'package:test_map/services/LocationProvider.dart';

// ignore: must_be_immutable
class ClassesPage extends StatelessWidget {
  Buildings building;
  ClassesPage({super.key, required this.building});

  List<ClassElement> classes = [];
  LocationProvider? locationProvider;

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);
    classes = building.getBuilding().floors.expand((floor) => floor.classes).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(building.getBuilding().name.toUpperCase()),
      ),
      body: Padding(
        padding: Specifications.padding_horizontal,
        child: ListView.builder(
          itemCount: classes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: Specifications.padding_only_bottom,
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: Specifications.borderRadius,
                    color: PageColors.aguColor),
                child: ListTile(
                  onTap: () {
                    locationProvider?.setNewTarget(classes[index]);
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => Scaffold(
                        body: const MapTab(),
                        appBar: AppBar(
                          leading: IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              locationProvider?.cancelTarget();
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                      ),
                    ));
                  },
                  title: Text(classes[index].name),
                  trailing: const Icon(Icons.arrow_forward),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
