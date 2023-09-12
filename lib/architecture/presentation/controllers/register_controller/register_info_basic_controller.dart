import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conductor_elegido/architecture/app/ui/utils/strings.dart';
import 'package:conductor_elegido/architecture/app/ui/utils/utils.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:conductor_elegido/architecture/app/routes/app_pages.dart';
import 'package:conductor_elegido/architecture/domain/repositories/authentication_repository_impl.dart';
import 'package:conductor_elegido/architecture/domain/use_cases/sing_up_usecase.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/error_snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterInfoBasicController extends GetxController {
  final picker = ImagePicker();
  File? idFrontImageCedula;
  File? idBackImageCedula;
  File? licenseFrontImage;
  File? licenseBackImage;
  final RxInt activeStepIndex = 0.obs;
  RxBool isObscure = true.obs;
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
  DateTime selectedDate = DateTime.now();

  late final AuthenticationRepositoryImpl userRepository;
  late final FirebaseAuth auth;
  final RxBool showProgressBar = false.obs;

  List<String> options = ['CC', 'Documento 2'];
  RxString currentItemSelected = "CC".obs;

  List<String> optionsCoverage = ['SURA', 'TU EPS'];
  RxString optionsCoverageItemSelected = "SURA".obs;

  bool areAllImagesUploaded = false;

  void togglePasswordVisibility() {
    isObscure.value = !isObscure.value;
  }

  Future<void> takeIdFrontPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      idFrontImageCedula = File(pickedFile.path);
      update();
    }

    areAllImagesUploaded = checkIfAllImagesUploaded();
  }

  Future<void> takeIdBackPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      idBackImageCedula = File(pickedFile.path);
      update();
    }

    areAllImagesUploaded = checkIfAllImagesUploaded();
  }

  Future<void> takeLicenseFrontPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      licenseFrontImage = File(pickedFile.path);
      update();
    }

    areAllImagesUploaded = checkIfAllImagesUploaded();
  }

  Future<void> takeLicenseBackPhoto() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      licenseBackImage = File(pickedFile.path);
      update();
    }

    areAllImagesUploaded = checkIfAllImagesUploaded();
  }

  Future<void> sendImages() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        if (idFrontImageCedula != null) {
          await uploadImageToFirebase(idFrontImageCedula!, userId, 'idFront');
          String downloadUrl = await firebase_storage.FirebaseStorage.instance
              .ref('$userId/idFront.jpg')
              .getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({'idFrontImageCedulaUrl': downloadUrl});
        }

        if (idBackImageCedula != null) {
          await uploadImageToFirebase(idBackImageCedula!, userId, 'idBack');
          String downloadUrl = await firebase_storage.FirebaseStorage.instance
              .ref('$userId/idBack.jpg')
              .getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({'idBackImageCedulaUrl': downloadUrl});
        }

        if (licenseFrontImage != null) {
          await uploadImageToFirebase(
              licenseFrontImage!, userId, 'licenseFront');
          String downloadUrl = await firebase_storage.FirebaseStorage.instance
              .ref('$userId/licenseFront.jpg')
              .getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({'licenseFrontImageUrl': downloadUrl});
        }

        if (licenseBackImage != null) {
          await uploadImageToFirebase(licenseBackImage!, userId, 'licenseBack');
          String downloadUrl = await firebase_storage.FirebaseStorage.instance
              .ref('$userId/licenseBack.jpg')
              .getDownloadURL();
          await FirebaseFirestore.instance
              .collection('users')
              .doc(userId)
              .update({'licenseBackImageUrl': downloadUrl});
        }
        Get.showSnackbar(const CustomSnackbar("Las imágenes se han subido y guardado en Firestore.", backgroundColors: Colors.lightGreen,icons: Icons.offline_pin,));
      }
    } catch (e) {        Get.showSnackbar(const CustomSnackbar("Las imágenes se han subido y guardado en Firestore.", backgroundColors: Colors.lightGreen,icons: Icons.offline_pin,));


    Get.snackbar('Error', 'No se pudo subir las imágenes: $e');
    }
  }

  Future<void> uploadImageToFirebase(File imageFile, String userId, String imageType) async {
    try {
      String fileName = '$userId/$imageType.jpg';
      await firebase_storage.FirebaseStorage.instance.ref(fileName).putFile(imageFile);
    } catch (e) {
      print('Error al subir la imagen: $e');
    }
  }

  @override
  void onInit() {
    super.onInit();
    userRepository = AuthenticationRepositoryImpl();
    auth = FirebaseAuth.instance;
    showProgressBar.value;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
    });
    dateBirthController.text = DateTime.now().toLocal().toString().split(' ')[0];
  }

  onRoleChanged(String newValue) {
    currentItemSelected.value = newValue;
  }

  bool validateFields() {
    return formKey.currentState!.validate() && formKey2.currentState!.validate();
  }

  Future<void> signUp() async {
    showProgressBar.value = true;
    if (formKey.currentState!.validate() || formKey2.currentState!.validate()) {
      if (!checkIfAllImagesUploaded()) {
        Get.showSnackbar(const CustomSnackbar("Debes subir todas las imágenes obligatorias."));
        showProgressBar.value = false;
        return;
      }

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
            optionsCoverageItemSelected.value.trim(),
            address.text.trim()
        );

        // Ahora, el usuario está registrado. se Sube las imágenes.
        await sendImages();

        Get.offNamed(Routes.HOME_VALIDATION);
        showProgressBar.value = false;
      } on FirebaseAuthException catch (e) {
        final customErrorMessage = firebaseAuthErrorTranslations[e.code] ?? "Error desconocido";
        Get.back();
        Get.showSnackbar(CustomSnackbar(customErrorMessage,icons: Icons.error_outline));
      } finally {
        showProgressBar.value = false;
      }
    }
  }

  bool checkIfAllImagesUploaded() {
    return idFrontImageCedula != null &&
        idBackImageCedula != null &&
        licenseFrontImage != null &&
        licenseBackImage != null;
  }

  Future<bool> isEmailAlreadyRegistered(String email) async {
    try {
      List<String> methods = await FirebaseAuth.instance.fetchSignInMethodsForEmail(email.trim());
      return methods.isNotEmpty;
    }on FirebaseAuthException catch (e) {
      final customErrorMessage = firebaseAuthErrorTranslations[e.code] ?? "Validar los campos.";
      Get.showSnackbar(CustomSnackbar(customErrorMessage,icons: Icons.error_outline));
      return false;
    }
  }

  Future<void> showCalendarAndUpdateText(
      BuildContext context,
      TextEditingController textController,
      ) async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      selectedDate = pickedDate;
      textController.text = pickedDate.toLocal().toString().split(' ')[0];
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
