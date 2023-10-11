import 'package:conductor_elegido/architecture/app/ui/utils/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../../domain/repositories/authentication_repository_impl.dart';
import '../pages/register/register_page.dart';

class HomeController extends GetxController {
  late final AuthenticationRepositoryImpl authenticationRepository;
  RxBool isSigningOut = false.obs;
  RxBool isUserActive = false.obs;
  RxBool isUserInRegistration = false.obs;
  late final FirebaseAuth _auth;

  @override
  void onInit() {
    super.onInit();
    authenticationRepository = AuthenticationRepositoryImpl();
    _auth = FirebaseAuth.instance;
    refreshData();
  }

  Future<void> refreshData() async {
    await fetchDataFromFirebase();
  }

  Future<void> fetchDataFromFirebase() async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        Map<String, dynamic>? userData = await authenticationRepository
            .getUserData(currentUser.uid);
        if (userData != null) {
          int status = userData['status'];

          // Actualizar la pantalla según el estado obtenido de Firebase
          if (status == AppStrings.activeDriverStatus) {
            isUserActive.value = true;
            isUserInRegistration.value = false;
            Get.offNamed("/home");

          } else if (status == AppStrings.driverStatusInRegistrationProgress) {
            isUserActive.value = false;
            isUserInRegistration.value = true;
            Get.offNamed("/validation");

          } else {
            isUserActive.value = false;
            isUserInRegistration.value = false;
          }
        }
      }
      // Actualizar la UI
      update();
    } catch (e) {
      print("Error al obtener datos de Firebase: $e");
    }
  }

  Future<void> signOut() async {
    try {
      isSigningOut.value = true;
      await _auth.signOut();
      Get.offAll(() => const LoginPage());
    } catch (e) {
      print("Error al cerrar sesión: $e");
    } finally {
      isSigningOut.value = false;
    }
  }
}
