import 'package:flutter/material.dart';
import 'package:test_map/models/building.dart';
import 'package:test_map/pages/floor_screen.dart';
import 'package:test_map/resources/specifications.dart';
import 'package:test_map/ui/CustomCard.dart';

class PlansTab extends StatelessWidget {
  const PlansTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
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
              itemCount: Buildings.values.length,
              itemBuilder: (context, index) {
                return CustomCard(
                  text: Buildings.values[index].name.toUpperCase(),
                  image: Buildings.values[index].getBuilding().image,
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => FloorScreen(
                          building: Buildings.values[index].getBuilding()),
                    ));
                  },
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
