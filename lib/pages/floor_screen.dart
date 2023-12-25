import 'package:flutter/material.dart';
import 'package:test_map/models/building.dart';
import 'package:test_map/pages/building_screen.dart';
import 'package:test_map/resources/colors.dart';

class FloorScreen extends StatelessWidget {
  FloorScreen({super.key, required this.building});
  IBuilding building;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
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
          builder: (context) => const PlanScreen(),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: floor.plan,
          ),
        ),
        child: Center(
          child: Text(
            "Floor ${floor.index}".toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold, color: PageColors.aguWhite, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
