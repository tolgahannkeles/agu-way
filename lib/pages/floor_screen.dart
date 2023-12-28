import 'package:flutter/material.dart';
import 'package:test_map/models/building.dart';
import 'package:test_map/models/floor.dart';
import 'package:test_map/pages/floor_plan_view.dart';
import 'package:test_map/resources/specifications.dart';

class FloorScreen extends StatelessWidget {
  FloorScreen({super.key, required this.building});
  IBuilding building;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(building.name),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: Specifications.padding_all,
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
                  crossAxisSpacing: 20,
                  mainAxisSpacing: 20,
                ),
                itemCount: building.floor_size,
                itemBuilder: (context, index) {
                  return _floorElement(context, building.floors[index]);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _floorElement(BuildContext context, FloorElement floor) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => FloorPlanView(
            floor: floor,
          ),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: Specifications.borderRadius,
          image: DecorationImage(
            fit: BoxFit.fill,
            image: floor.plan,
          ),
        ),
        child: Center(
          child: Text(
            "Floor ${floor.index}".toUpperCase(),
            style: Specifications.titleStyle,
          ),
        ),
      ),
    );
  }
}
