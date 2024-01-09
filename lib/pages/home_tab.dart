import 'package:flutter/material.dart';
import 'package:test_map/models/building.dart';
import 'package:test_map/pages/classes_page.dart';
import 'package:test_map/resources/specifications.dart';
import 'package:test_map/ui/CustomCard.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
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
            text: Buildings.values[index].getBuilding().name.toUpperCase(),
            image: Buildings.values[index].getBuilding().image,
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                builder: (context) =>
                    ClassesPage(building: Buildings.values[index]),
              ));
            },
          );
        },
      ),
    );
  }
}
