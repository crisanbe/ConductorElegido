import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool isSigningOut = false.obs; // Variable de estado

  Future<void> signOut() async {
    try {
      isSigningOut.value = true; // Inicia el proceso de cierre de sesión
      await _auth.signOut();
      // Cierre de sesión exitoso, puedes realizar acciones adicionales si es necesario.
    } catch (e) {
      // Manejar los errores de cierre de sesión.
      print("Error al cerrar sesión: $e");
    } finally {
      isSigningOut.value = false; // Finaliza el proceso de cierre de sesión
    }
  }
}