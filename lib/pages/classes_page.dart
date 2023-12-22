import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test_map/data/location_data.dart';
import 'package:test_map/models/location.dart';
import 'package:test_map/pages/map_tab.dart';
import 'package:test_map/resources/colors.dart';
import 'package:test_map/services/LocationProvider.dart';

class ClassesPage extends StatelessWidget {
  Buildings building;
  ClassesPage({super.key, required this.building});

  List<LocationModel> classes = [];
  LocationProvider? locationProvider;

  @override
  Widget build(BuildContext context) {
    locationProvider = Provider.of<LocationProvider>(context);

    classes = DummyData.locations
        .where(
          (element) => element.building == building,
        )
        .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(building.name.toUpperCase()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: ListView.builder(
          itemCount: classes.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: PageColors.aguColor),
                child: ListTile(
                  iconColor: PageColors.aguWhite,
                  textColor: PageColors.aguWhite,
                  onTap: () {
                    locationProvider?.setNewTarget(building.getLocation());
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
                  title: Text(classes[index].roomName),
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
