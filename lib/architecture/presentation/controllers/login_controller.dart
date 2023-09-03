import 'package:conductor_elegido/architecture/app/routes/app_pages.dart';
import 'package:conductor_elegido/architecture/app/ui/utils/strings.dart';
import 'package:conductor_elegido/architecture/domain/repositories/user_repository_impl.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/error_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final UserRepositoryImpl userRepository;
  late final FirebaseAuth auth;
  final RxString userStatus = "En proceso".obs;
  String get userStatusValue => userStatus.value;
  final RxString status = "".obs;
  RxBool isObscure = true.obs;
  late final RxBool _showProgress;
  bool get showProgress => _showProgress.value;

  @override
  void onInit() {
    super.onInit();
    userRepository = UserRepositoryImpl();
    auth = FirebaseAuth.instance;
    _showProgress = false.obs;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        checkRegistrationStatus();
      }
    });
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  String updateUserStatus(String newStatus) {
    status.value = newStatus;
    return newStatus;
  }

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }

  Future<void> signIn() async {
    if (formKey.currentState!.validate()) {
      _showProgressDialog();
      try {
        await auth.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text,
        );
        await checkRegistrationStatus();// verificar y actualizar el estado después de iniciar sesión
        Get.back();
        _navigateBasedOnStatus();
      } on FirebaseAuthException catch (e) {
        Get.back();
        Get.showSnackbar(ErrorSnackbar(e.message ?? e.code));
      }
    }
  }

  void _showProgressDialog() {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  void _navigateBasedOnStatus() {
    if (status.value == AppStrings.activeStatus) {
      Get.offNamed(Routes.HOME);
    } else if (status.value == AppStrings.inProgressStatus) {
      Get.offNamed(Routes.REGISTER);
    }
  }

  checkRegistrationStatus() async {
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      Map<String, dynamic>? userData = await userRepository.getUserData(currentUser.uid);
      if (userData != null) {
        updateUserStatus(userData['status']);
        update();
      }
    }
  }
}
