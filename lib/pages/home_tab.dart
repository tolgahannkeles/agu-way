import 'package:flutter/material.dart';
import 'package:test_map/models/building.dart';
import 'package:test_map/pages/classes_page.dart';
import 'package:test_map/resources/colors.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: MediaQuery.of(context).size.width * 0.5,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        itemCount: Buildings.values.length,
        itemBuilder: (context, index) {
          return _buildingElement(context, Buildings.values[index]);
        },
      ),
    );
  }

  Widget _buildingElement(BuildContext context, Buildings building) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ClassesPage(building: building),
        ));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            fit: BoxFit.fill,
            image: building.getBuilding().image,
          ),
        ),
        child: Center(
          child: Text(
            building.getBuilding().name.toUpperCase(),
            style: TextStyle(
                fontWeight: FontWeight.bold, color: PageColors.aguWhite, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
