import 'package:conductor_elegido/architecture/app/ui/utils/strings.dart';
import 'package:conductor_elegido/architecture/presentation/controllers/gps_controller/Android/locationController.dart';
import 'package:conductor_elegido/architecture/presentation/controllers/gps_controller/ios/geolocator_Controller.dart';
import 'package:conductor_elegido/architecture/presentation/controllers/login_controller.dart';
import 'package:conductor_elegido/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:conductor_elegido/architecture/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final LocationController locationController = Get.put(LocationController());
  final GeolocatorController geolocatorController = Get.put(GeolocatorController());
  final LoginController registerController = Get.put(LoginController());
  final initialRoute = await _getInitialRoute(registerController);

  geolocatorController.checkPermissionAndGetLocation();
  locationController.checkLocationPermission();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: initialRoute,
    theme: ThemeData(),
    defaultTransition: Transition.native,
    getPages: AppPages.pages,
  ));
}

Future<String> _getInitialRoute(LoginController registerController) async {
  final auth = FirebaseAuth.instance;
  final currentUser = auth.currentUser;

  if (currentUser == null) {
    // El usuario ha cerrado sesión, así que limpia el estado local.
    registerController.updateUserStatus("");
  }

  if (currentUser != null) {
    final userData = await registerController.authenticationRepository.getUserData(currentUser.uid);
    if (userData != null) {
      final status = userData['status'];
      if (status == AppStrings.activeDriverStatus) {
        return Routes.HOME;
      } else if (status == AppStrings.driverStatusInRegistrationProgress) {
        return Routes.HOME_VALIDATION;
      }
    }
  }
  return Routes.LOGIN; // Default route para otros casos
}

