import 'package:conductor_elegido/architecture/presentation/controllers/login_controller.dart';
import 'package:conductor_elegido/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:conductor_elegido/architecture/app/bindings/splash_binding.dart';
import 'package:conductor_elegido/architecture/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final RegisterController registerController = Get.put(RegisterController());
  final initialRoute = await _getInitialRoute(registerController);

  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: initialRoute,
    theme: ThemeData(

    ),
    defaultTransition: Transition.native,
    initialBinding: SplashBinding(),
    getPages: AppPages.pages,
  ));
}

Future<String> _getInitialRoute(RegisterController registerController) async {
  final auth = FirebaseAuth.instance;
  final currentUser = auth.currentUser;

  if (currentUser == null) {
    // El usuario ha cerrado sesión, así que limpia el estado local.
    registerController.updateUserStatus("");
  }

  if (currentUser != null) {
    final userData = await registerController.userRepository.getUserData(currentUser.uid);
    if (userData != null) {
      final status = userData['status'];
      if (status == "Activo") {
        return Routes.HOME;
      } else if (status == "En proceso") {
        return Routes.REGISTER;
      }
    }
  }

  return Routes.LOGIN; // Default route para otros casos
}

