import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../pages/register/register_page.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isSigningOut = false.obs;

  Future<void> signOut() async {
    try {
      isSigningOut.value = true; // Inicia el proceso de cierre de sesión
      await _auth.signOut();
      Get.offAll(() => const LoginPage());
    } catch (e) {
      print("Error al cerrar sesión: $e");
    } finally {
      isSigningOut.value = false;
    }
  }
}