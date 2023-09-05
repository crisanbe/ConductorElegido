import 'package:get/get.dart';
import 'package:location/location.dart';

class LocationController extends GetxController {
  Location location = Location();
  RxBool serviceEnabled = false.obs;
  Rx<PermissionStatus> permissionGranted = PermissionStatus.denied.obs;
  Rx<LocationData> locationData = LocationData.fromMap({}).obs;

  @override
  void onInit() {
    super.onInit();
    checkLocationPermission();
  }

  Future<void> checkLocationPermission() async {
    serviceEnabled.value = await location.serviceEnabled();
    if (!serviceEnabled.value) {
      serviceEnabled.value = await location.requestService();
      if (!serviceEnabled.value) {
        // El usuario no habilitó el servicio de ubicación, maneja esto como desees.
        return;
      }
    }
    permissionGranted.value = await location.hasPermission();
    if (permissionGranted.value == PermissionStatus.denied) {
      permissionGranted.value = await location.requestPermission();
      if (permissionGranted.value != PermissionStatus.granted) {
        // El usuario no otorgó permisos de ubicación, maneja esto como desees.
        return;
      }
    }
  }
  Future<void> getCurrentLocation() async {
    locationData.value = await location.getLocation();
  }
}
