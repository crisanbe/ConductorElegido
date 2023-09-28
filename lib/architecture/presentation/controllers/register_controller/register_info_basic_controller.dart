import 'dart:async';
import 'dart:io';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conductor_elegido/architecture/app/ui/utils/utils.dart';
import 'package:conductor_elegido/architecture/domain/repositories/authentication_repository_impl.dart';
import 'package:conductor_elegido/architecture/domain/use_cases/sing_up_usecase.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/error_snackbar.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class RegisterInfoBasicController extends GetxController {
  final picker = ImagePicker();
  File? idFrontImageCedula;
  File? idBackImageCedula;
  File? licenseFrontImage;
  File? licenseBackImage;

  File? selectedDocument1;
  File? selectedDocument2;
  File? selectedDocument3;

  RxString pdfFilePath = ''.obs;
  final RxInt activeStepIndex = 0.obs;
  RxBool isObscure = true.obs;
  final formKey = GlobalKey<FormState>();
  final formKey2 = GlobalKey<FormState>();
  final TextEditingController fullName = TextEditingController();
  final TextEditingController document = TextEditingController();
  final TextEditingController contacto = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final RxInt userStatus = RxInt(2);
  final TextEditingController dateBirthController = TextEditingController();
  final TextEditingController fechaVigenciaA2 = TextEditingController();
  final TextEditingController fechaVigenciaB1 = TextEditingController();
  final TextEditingController fechaVigenciaC1 = TextEditingController();
  final TextEditingController zoneCoverage = TextEditingController();
  final TextEditingController address = TextEditingController();

  late final AuthenticationRepositoryImpl userRepository;
  late final FirebaseAuth auth;
  final RxBool showProgressBar = RxBool(false);
  List<String> options = ['CC', 'Documento 2'];
  RxString currentItemSelected = "CC".obs;

  List<String> optionsEps = ['SURA', 'TU EPS'];
  RxString optionsEpsItemSelected = "SURA".obs;

  List<String> optionsCoverage = ['BOGOTA', 'MEDELLIN'];
  RxString optionsCoverageItemSelected = "BOGOTA".obs;

  bool areAllImagesUploaded = false;
  bool isCategoryA2Selected = false;
  bool isCategoryB1Selected = false;
  bool isCategoryC1Selected = false;
  bool showExpirationDateA2 = false;
  bool showExpirationDateB1 = false;
  bool showExpirationDateC1 = false;

  File? antecedentesJudicialesFile;
  File? antecedentesProcuraduriaFile;
  File? antecedentesPoliciaFile;

  void onCategorySelected(bool value, String category) {
    switch (category) {
      case 'A2':
        isCategoryA2Selected = value;
        showExpirationDateA2 = value;
        break;
      case 'B1':
        isCategoryB1Selected = value;
        showExpirationDateB1 = value;
        break;
      case 'C1':
        isCategoryC1Selected = value;
        showExpirationDateC1 = value;
        break;
    }
    update();
  }

  void togglePasswordVisibility() {
    showProgressBar.value = true;
    isObscure.value = !isObscure.value;
  }

  Future<void> takeIdFrontPhoto() async {
    showProgressBar.value = true;
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      idFrontImageCedula = File(pickedFile.path);
      update();
    }

    areAllImagesUploaded = checkIfAllImagesUploaded();
    showProgressBar.value = false;
  }

  Future<void> takeIdBackPhoto() async {
    showProgressBar.value = true;
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      idBackImageCedula = File(pickedFile.path);
      update();
    }

    areAllImagesUploaded = checkIfAllImagesUploaded();
    showProgressBar.value = false;
  }

  Future<void> takeLicenseFrontPhoto() async {
    showProgressBar.value = true;
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      licenseFrontImage = File(pickedFile.path);
      update();
    }

    areAllImagesUploaded = checkIfAllImagesUploaded();
    showProgressBar.value = false;
  }

  Future<void> takeLicenseBackPhoto() async {
    showProgressBar.value = true;
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      licenseBackImage = File(pickedFile.path);
      update();
    }

    areAllImagesUploaded = checkIfAllImagesUploaded();
    showProgressBar.value = false;
  }

  bool isUserAdult(DateTime dateOfBirth) {
    DateTime currentDate = DateTime.now();
    DateTime adultDate = currentDate.subtract(const Duration(days: 18 * 365)); // Restar 18 años

    return dateOfBirth.isBefore(adultDate);
  }

  Future<void> sendImages() async {
    showProgressBar.value = true; // Mostrar indicador de carga antes de enviar imágenes
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
              .collection('driver')
              .doc(userId)
              .update({'idFrontImageCedulaUrl': downloadUrl});
        }

        if (idBackImageCedula != null) {
          await uploadImageToFirebase(idBackImageCedula!, userId, 'idBack');
          String downloadUrl = await firebase_storage.FirebaseStorage.instance
              .ref('$userId/idBack.jpg')
              .getDownloadURL();
          await FirebaseFirestore.instance
              .collection('driver')
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
              .collection('driver')
              .doc(userId)
              .update({'licenseFrontImageUrl': downloadUrl});
        }

        if (licenseBackImage != null) {
          await uploadImageToFirebase(licenseBackImage!, userId, 'licenseBack');
          String downloadUrl = await firebase_storage.FirebaseStorage.instance
              .ref('$userId/licenseBack.jpg')
              .getDownloadURL();
          await FirebaseFirestore.instance
              .collection('driver')
              .doc(userId)
              .update({'licenseBackImageUrl': downloadUrl});
        }
        // Indicar que todas las imágenes se han subido correctamente
        areAllImagesUploaded = true;
        Get.showSnackbar(const CustomSnackbar("Las imágenes se han subido y guardado en Firestore.", backgroundColors: Colors.lightGreen,icons: Icons.offline_pin,));
      }
    } catch (e) {Get.snackbar('Error', 'No se pudo subir las imágenes: $e');}
    finally {
      showProgressBar.value = false; // Ocultar indicador de carga cuando se haya completado el envío de imágenes
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

  Future<void> uploadFileToFirebase(File file, String userId, String storagePath) async {
    try {
      String fileName = '$userId/$storagePath';
      await firebase_storage.FirebaseStorage.instance.ref(fileName).putFile(file);

      // Obtener el enlace de descarga
      String downloadUrl = await firebase_storage.FirebaseStorage.instance
          .ref(fileName)
          .getDownloadURL();

      // Guardar el enlace en la colección driver
      await FirebaseFirestore.instance
          .collection('driver')
          .doc(userId)
          .update({'${storagePath}Url': downloadUrl}); // Asumiendo que el campo se llama 'nombreDelCampoUrl'

    } catch (e) {
      print('Error al subir el archivo: $e');
    }
  }

  Future<void> sendFilesToFirebase() async {
    showProgressBar.value = true;
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        // Crear una función para obtener el nombre del archivo a partir del path
        String getFileNameFromPath(File file) {
          return path.basename(file.path);
        }

        // Enviar el primer documento si está seleccionado
        if (selectedDocument1 != null) {
          await uploadFileToFirebase(selectedDocument1!, userId, 'documents/${getFileNameFromPath(selectedDocument1!)}');
          String downloadUrl = await firebase_storage.FirebaseStorage.instance
              .ref('$userId/documents/${getFileNameFromPath(selectedDocument1!)}')
              .getDownloadURL();
          await FirebaseFirestore.instance
              .collection('driver')
              .doc(userId)
              .update({'antesedentes1Url': downloadUrl});
        }

        // Enviar el segundo documento si está seleccionado
        if (selectedDocument2 != null) {
          await uploadFileToFirebase(selectedDocument2!, userId, 'documents/${getFileNameFromPath(selectedDocument2!)}');
          String downloadUrl = await firebase_storage.FirebaseStorage.instance
              .ref('$userId/documents/${getFileNameFromPath(selectedDocument2!)}')
              .getDownloadURL();
          await FirebaseFirestore.instance
              .collection('driver')
              .doc(userId)
              .update({'antesedentes2Url': downloadUrl});
        }

        // Enviar el tercer documento si está seleccionado
        if (selectedDocument3 != null) {
          await uploadFileToFirebase(selectedDocument3!, userId, 'documents/${getFileNameFromPath(selectedDocument3!)}');
          String downloadUrl = await firebase_storage.FirebaseStorage.instance
              .ref('$userId/documents/${getFileNameFromPath(selectedDocument3!)}')
              .getDownloadURL();
          await FirebaseFirestore.instance
              .collection('driver')
              .doc(userId)
              .update({'antesedentes3Url': downloadUrl});
        }

        Get.showSnackbar(const CustomSnackbar(
          "Los documentos se han subido y guardado en Firestore.",
          backgroundColors: Colors.lightGreen,
          icons: Icons.offline_pin,
        ));
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudieron subir los documentos: $e');
    } finally {
      showProgressBar.value = false;
    }
  }


  void selectDocument(int documentNumber) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      File selectedDocument = File(file.path ?? "Ningún archivo seleccionado");

      switch (documentNumber) {
        case 1:
          selectedDocument1 = selectedDocument;
          break;
        case 2:
          selectedDocument2 = selectedDocument;
          break;
        case 3:
          selectedDocument3 = selectedDocument;
          break;
        default:
        // Manejar un número de documento inválido si es necesario
          break;
      }
    }
  }


  @override
  void onInit() {
    super.onInit();
    userRepository = AuthenticationRepositoryImpl();
    auth = FirebaseAuth.instance;
    showProgressBar.value;
    FirebaseAuth.instance.authStateChanges().listen((User? user) {});
  }

  onDocumentChanged(String newValue) {
    currentItemSelected.value = newValue;
  }

  onEpsChanged(String newValue) {
    optionsEpsItemSelected.value = newValue;
  }

  onCoverageChanged(String newValue) {
    optionsCoverageItemSelected.value = newValue;
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

      // Validar que al menos una categoría esté seleccionada
      if (!isCategoryA2Selected &&
          !isCategoryB1Selected &&
          !isCategoryC1Selected) {
        Get.showSnackbar(const CustomSnackbar("Debes seleccionar al menos una categoría."));
        showProgressBar.value = false;
        return;
      }

      try {
        List<String> categorias = ['A2', 'B1', 'C1'];

        DateTime? fechaA2 = fechaVigenciaA2.text.trim().isNotEmpty ? DateTime.parse(fechaVigenciaA2.text.trim()) : null;
        DateTime? fechaB1 = fechaVigenciaB1.text.trim().isNotEmpty ? DateTime.parse(fechaVigenciaB1.text.trim()) : null;
        DateTime? fechaC1 = fechaVigenciaC1.text.trim().isNotEmpty ? DateTime.parse(fechaVigenciaC1.text.trim()) : null;

        Map<String, DateTime?> fechasExpedicion = {
          if (fechaA2 != null) 'A2': fechaA2,
          if (fechaB1 != null) 'B1': fechaB1,
          if (fechaC1 != null) 'C1': fechaC1,
        };

        // Validar la vigencia de las categorías
        if (fechaA2 != null && fechaA2.isBefore(DateTime.now())) {
          Get.showSnackbar(const CustomSnackbar("La categoría A2 está vencida. No se puede registrar."));
          showProgressBar.value = false;
          return;
        }

        if (fechaB1 != null && fechaB1.isBefore(DateTime.now())) {
          Get.showSnackbar(const CustomSnackbar("La categoría B1 está vencida. No se puede registrar."));
          showProgressBar.value = false;
          return;
        }

        if (fechaC1 != null && fechaC1.isBefore(DateTime.now())) {
          Get.showSnackbar(const CustomSnackbar("La categoría C1 está vencida. No se puede registrar."));
          showProgressBar.value = false;
          return;
        }

        final signUpUseCase = SignUpUseCase(userRepository);
        DateTime dateBirth = DateTime.parse(dateBirthController.text.trim());
        tz.initializeTimeZones(); // Inicializa las zonas horarias
        final location = tz.getLocation('America/Bogota');
        DateTime dateOfRegistration = tz.TZDateTime.now(location);
        int status = userStatus.value;

        if (!isUserAdult(dateBirth)) {
          Get.showSnackbar(const CustomSnackbar("El usuario debe tener al menos 18 años para registrarse."));
          showProgressBar.value = false;
          return;
        }

        showProgressBar.value = true;
        await signUpUseCase.execute(
            currentItemSelected.value.trim(),
            document.text.trim(),
            fullName.text.trim(),
            contacto.text.trim(),
            email.text.trim(),
            passwordController.text.trim(),
            status,
            dateBirth,
            optionsCoverageItemSelected.value.trim(),
            optionsEpsItemSelected.value.trim(),
            address.text.trim(),
            dateOfRegistration.toIso8601String()
        );
        await enviarDatosAFirebase(categorias, fechasExpedicion);
        await sendImages();
        await sendFilesToFirebase();

        Get.offAllNamed("/validation");

      } on FirebaseAuthException catch (e) {
        final customErrorMessage = firebaseAuthErrorTranslations[e.code] ?? "Error desconocido";
        //Get.back();
        Get.showSnackbar(CustomSnackbar(customErrorMessage, icons: Icons.error_outline));
      } finally {
        showProgressBar.value = false;
      }
    } else {
      showProgressBar.value = false;
    }
  }

  Future<void> enviarDatosAFirebase(List<String> categories, Map<String, DateTime?> datesExpedition) async {
    showProgressBar.value = true;
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        String userId = user.uid;

        Map<String, String> categoriesWithDates = {};

        for (var categorie in categories) {
          DateTime? date = datesExpedition[categorie];
          if (date != null) {
            categoriesWithDates[categorie] = '($categorie) - ${date.toIso8601String()}';
          }
        }

        if (categoriesWithDates.isNotEmpty) {
          await FirebaseFirestore.instance.collection('driver').doc(userId).set(
            {'categories_and_dates': categoriesWithDates},
            SetOptions(merge: true),
          );

          Get.showSnackbar(const CustomSnackbar("Información enviada a Firebase.", backgroundColors: Colors.lightGreen, icons: Icons.offline_pin));
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'No se pudo enviar la información a Firebase: $e');
    }finally {
      showProgressBar.value = false;
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
      TextEditingController textController, {
      String? field,
      }) async {

    DateTime selectedDate = DateTime.now();
    DateTime lastSelectableDate;

    // Verificar si el campo es la fecha de nacimiento
    if (field == 'dateBirth') {
      lastSelectableDate = DateTime.now();
    } else {
      lastSelectableDate = DateTime(2101);
    }

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate ,
      firstDate: DateTime(1900),
      lastDate: lastSelectableDate,
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
