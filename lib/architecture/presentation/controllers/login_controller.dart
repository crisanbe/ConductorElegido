import 'dart:ffi';

import 'package:conductor_elegido/architecture/app/routes/app_pages.dart';
import 'package:conductor_elegido/architecture/app/ui/utils/strings.dart';
import 'package:conductor_elegido/architecture/app/ui/utils/utils.dart';
import 'package:conductor_elegido/architecture/domain/repositories/authentication_repository_impl.dart';
import 'package:conductor_elegido/architecture/domain/use_cases/login_usecase.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/error_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  late final AuthenticationRepositoryImpl authenticationRepository;
  late final FirebaseAuth auth;
  final RxInt status = 0.obs;
  RxBool isObscure = true.obs;
  late final RxBool _showProgress;
  bool get showProgress => _showProgress.value;

  @override
  void onInit() {
    super.onInit();
    authenticationRepository = AuthenticationRepositoryImpl();
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

  int updateUserStatus(int newStatus) {
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
        await LoginUseCase(authenticationRepository).login(
          emailController.text.trim(),
          passwordController.text,
        );
        await checkRegistrationStatus();// verificar y actualizar el estado después de iniciar sesión
        Get.back();
        _navigateBasedOnStatus();
      }on FirebaseAuthException catch (e) {
        final customErrorMessage = firebaseAuthErrorTranslations[e.code] ?? "Error desconocido";
        Get.back();
        Get.showSnackbar(CustomSnackbar(customErrorMessage,icons: Icons.error_outline));
      }
    }
  }

  void _showProgressDialog() {
    Get.dialog(
      const Center(child: CircularProgressIndicator(color: Colors.blueAccent,)),
      barrierDismissible: false,
    );
  }

  void _navigateBasedOnStatus() {
    if (status.value == AppStrings.activeDriverStatus) {
      Get.offNamed(Routes.HOME);
    } else if (status.value == AppStrings.driverStatusInRegistrationProgress) {
      Get.offNamed(Routes.HOME_VALIDATION);
    }
  }

  checkRegistrationStatus() async {
    final currentUser = auth.currentUser;
    if (currentUser != null) {
      Map<String, dynamic>? userData = await authenticationRepository.getUserData(currentUser.uid);
      if (userData != null) {
        updateUserStatus(userData['status']);
        update();
      }
    }
  }
}
