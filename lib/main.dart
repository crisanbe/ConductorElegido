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

Future<String> _getInitialRoute(LoginController loginController) async {
  final auth = FirebaseAuth.instance;
  final currentUser = auth.currentUser;

  if (currentUser == null) {
    loginController.updateUserStatus();
    return Routes.LOGIN;
  } else {
    final userData = await loginController.authenticationRepository.getUserData(currentUser.uid);

    if (userData != null) {
      final status = userData['status'];
      if (status == AppStrings.activeDriverStatus) {
        return Routes.HOME;
      } else if (status == AppStrings.driverStatusInRegistrationProgress) {
        return Routes.HOME_VALIDATION;
      }
    }
    // Si no hay datos de usuario o el estado no coincide con ninguno de los casos anteriores,
    // redirigir a una pantalla de inicio por defecto.
    return Routes.LOGIN;
  }
}

