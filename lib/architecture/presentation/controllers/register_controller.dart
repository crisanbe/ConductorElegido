import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conductor_elegido/architecture/app/routes/app_pages.dart';
import 'package:conductor_elegido/architecture/domain/repositories/user_repository_impl.dart';
import 'package:conductor_elegido/architecture/domain/use_cases/sing_up_usecase.dart';
import 'package:conductor_elegido/architecture/presentation/pages/home/home_pages.dart';
import 'package:conductor_elegido/architecture/presentation/pages/register/register_page.dart';
import 'package:conductor_elegido/architecture/presentation/pages/register_pantalla_info_basic/register_info_basic_page.dart';
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


  Future<void> signUp() async {
    _showProgress.value = true;
    if (formKey.currentState!.validate()) {
      try {
        final signUpUseCase = SignUpUseCase(userRepository);
        await signUpUseCase.execute(
          emailController.text.trim(),
          passwordController.text,
          userStatus.value.trim(),
        );
        Get.offNamed(Routes.REGISTER1);
      } catch (e) {
        print('Sign up failed: $e');
      } finally {
        _showProgress.value = false;
      }
    } else {
      _showProgress.value = false;
    }
  }

  void _showProgressDialog() {
    Get.dialog(
      const Center(child: CircularProgressIndicator()),
      barrierDismissible: false,
    );
  }

  void _navigateBasedOnStatus() {
    if (status.value == "Activo") {
      Get.offNamed(Routes.HOME);
    } else if (status.value == "En proceso") {
      Get.offNamed(Routes.REGISTER1);
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
