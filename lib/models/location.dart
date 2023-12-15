import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationModel {
  String roomName;
  Buildings building;
  String assetName;

  LocationModel(
      {required this.roomName, required this.building, required this.assetName});
}

enum Buildings {
  steel,
  warehouse,
  lab,
  factory,
}

extension BuildingExtension on Buildings {
  LatLng getLocation() {
    switch (name) {
      case "steel":
        return const LatLng(38.737110, 35.473559);
      case "warehouse":
        return const LatLng(38.737042, 35.474362);
      case "lab":
        return const LatLng(38.740216, 35.475138);
      case "factory":
        return const LatLng(38.738845, 35.474455);
      default:
        return const LatLng(0, 0);
    }
  }

  NetworkImage getImage() {
    switch (name) {
      case "steel":
        return const NetworkImage(
          "https://images.divisare.com/images/c_limit,f_auto,h_2000,q_auto,w_3000/v1494235636/bhubfukr0ufbyxahr3ka/eaa-emre-arolat-architecture-cemal-emden-studio-majo-agu-sumer-campus.jpg",
        );
      case "warehouse":
        return const NetworkImage(
            "https://www.arkitera.com/wp-content/uploads/2017/01/AG%C3%9C-S%C3%BCmer-Kamp%C3%BCs%C3%BC-B%C3%BCy%C3%BCk-Ambar-Binas%C4%B1-Restorasyon-Projesi-18-615x375.jpg");
      case "lab":
        return const NetworkImage(
            "https://www.veritastr.com/images/uploads/tk_022A6116-C487-4AE0-1A3D-6601D5D258F8.jpg");
      case "factory":
        return const NetworkImage(
            "https://images.adsttc.com/media/images/64d6/3a89/8177/ff6a/e7c7/39b8/newsletter/agu-presidential-museum-and-library-eaa-emre-arolat-architecture_27.jpg?1691761390");
      default:
        return const NetworkImage(
            "https://seeklogo.com/images/A/abdullah-gul-universitesi-logo-50B4B48AD4-seeklogo.com.png");
    }
  }
}
