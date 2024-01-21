import 'package:flutter/material.dart';
import 'package:test_map/resources/specifications.dart';

// ignore: must_be_immutable
class CustomCard extends StatelessWidget {
  String text;
  ImageProvider image;
  void Function() onTap;

  CustomCard({super.key, required this.text, required this.image, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Card(
        borderOnForeground: true,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: Specifications.borderRadius,
            image: DecorationImage(fit: BoxFit.fill, image: image),
          ),
          child: Center(
            child: Text(
              text,
              style: Specifications.cardText,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
    );
  }
}
