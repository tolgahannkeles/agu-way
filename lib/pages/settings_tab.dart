import 'package:flutter/material.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(
      image: NetworkImage(
        "https://www.lodoshaber.com/static/34/346862-recep-ivedik-in-bursa-dan-paylastigi-video-olay-oldu-5bb4851e8d7e3-x750.webp",
      ),
      fit: BoxFit.fill,
    );
  }
}
