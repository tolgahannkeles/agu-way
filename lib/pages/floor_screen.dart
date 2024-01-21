import 'package:flutter/material.dart';
import 'package:test_map/models/building.dart';
import 'package:test_map/pages/floor_plan_view.dart';
import 'package:test_map/resources/specifications.dart';
import 'package:test_map/ui/CustomCard.dart';

// ignore: must_be_immutable
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
                  return CustomCard(
                    text: "${building.floors[index].floor.name} Floor".toUpperCase(),
                    image: building.floors[index].plan,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => FloorPlanView(
                          floor: building.floors[index],
                        ),
                      ));
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
