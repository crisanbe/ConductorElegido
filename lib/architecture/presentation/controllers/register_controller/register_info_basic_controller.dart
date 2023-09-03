import 'package:conductor_elegido/architecture/app/routes/app_pages.dart';
import 'package:conductor_elegido/architecture/domain/repositories/user_repository_impl.dart';
import 'package:conductor_elegido/architecture/domain/use_cases/sing_up_usecase.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/error_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterInfoBasicController extends GetxController {
  final RxInt activeStepIndex = 0.obs;
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController document = TextEditingController();
  final TextEditingController contacto = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxString userStatus = "En proceso".obs;
  final TextEditingController dateBirthController = TextEditingController();
  final TextEditingController dateExpirationLicense = TextEditingController();
  final TextEditingController licensCurrentlyExpired = TextEditingController();
  final TextEditingController zoneCoverage = TextEditingController();
  final TextEditingController address = TextEditingController();
  DateTime selectedDate = DateTime.now(); // Esta variable almacena la fecha seleccionada

  late final UserRepositoryImpl userRepository;
  late final FirebaseAuth auth;
  late final RxBool _showProgress;
  bool get showProgress => _showProgress.value;

  List<String> options = ['CC', 'Documento 2'];
  RxString currentItemSelected = "CC".obs;

  @override
  void onInit() {
    super.onInit();
    userRepository = UserRepositoryImpl();
    auth = FirebaseAuth.instance;
    _showProgress = false.obs;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
    });
    dateBirthController.text = DateTime.now().toLocal().toString().split(' ')[0];
  }

   onRoleChanged(String newValue) {
    currentItemSelected.value = newValue;
  }

  Future<void> signUp() async {
    _showProgress.value = true;
    if (formKey.currentState!.validate() || formKey2.currentState!.validate()) {
      try {
        final signUpUseCase = SignUpUseCase(userRepository);
        DateTime dateBirth = DateTime.parse(dateBirthController.text.trim());
        DateTime dateExpiration = DateTime.parse(dateExpirationLicense.text.trim());
        DateTime fechaVencimiento = DateTime.parse(licensCurrentlyExpired.text.trim());
        await signUpUseCase.execute(
          currentItemSelected.value.trim(),
          document.text.trim(),
          fullName.text.trim(),
          contacto.text.trim(),
          email.text.trim(),
          passwordController.text.trim(),
          userStatus.value.trim(),
            dateBirth,
            dateExpiration,
            fechaVencimiento,
            zoneCoverage.text.trim(),
          address.text.trim()
        );
        Get.offNamed(Routes.REGISTER);
      } on FirebaseAuthException catch (e) {
        Get.back();
        Get.showSnackbar(ErrorSnackbar(e.message ?? e.code));
      } finally {
        _showProgress.value = false;
      }
    } else {
      _showProgress.value = false;
    }
  }

  Future<void> showCalendar(BuildContext context) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate;
      dateBirthController.text = pickedDate.toLocal().toString().split(' ')[0];
      dateExpirationLicense.text = pickedDate.toLocal().toString().split(' ')[0];
      licensCurrentlyExpired.text = pickedDate.toLocal().toString().split(' ')[0];
    }
  }
   onNextStep(List<Step> steps) {
    if (activeStepIndex.value < (steps.length - 1)) {
      activeStepIndex.value++;
    } else {
      print('Submited');
    }
  }

  void onPreviousStep() {
    if (activeStepIndex.value > 0) {
      activeStepIndex.value--;
    }
  }
}

