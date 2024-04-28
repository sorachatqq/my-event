import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../helper/determinPosition.dart';

class LocationState extends GetxController {
  final currentLocation = LatLng(0, 0).obs;

  @override
  void onInit() {
    init();
    super.onInit();
  }

  void init() async {
    await load();
  }

  Future<Position> load() async {
    Position lastPosition = await DeterminePosition.determinePosition();
    currentLocation.value =
        LatLng(lastPosition.latitude, lastPosition.longitude);
    return lastPosition;
  }
}
