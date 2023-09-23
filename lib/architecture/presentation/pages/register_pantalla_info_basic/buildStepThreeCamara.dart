import 'package:conductor_elegido/architecture/presentation/controllers/register_controller/register_info_basic_controller.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/atomos/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildStepThreeCamara extends GetView<RegisterInfoBasicController> {
  const BuildStepThreeCamara({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterInfoBasicController>(builder: (_) {
      return Center(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/mobile_photos.png',
                fit: BoxFit.cover,
                width: 150, // Cambia el ancho según tus preferencias
                height: 150, // Cambia la altura según tus preferencias
              ),
            ),

            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Trabaja con nosotros",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 7),
            const Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  "Información complementaria",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            // Fila 1: Fotos por delante
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Foto por delante de la licencia
                GestureDetector(
                  onTap: () async {
                    await controller.takeIdFrontPhoto();
                    if (controller.idFrontImageCedula != null) {
                      _.update();
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15), // Bordes redondeados
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (controller.idFrontImageCedula != null)
                          Image.file(
                            controller.idFrontImageCedula!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        if (controller.idFrontImageCedula != null)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 40,
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (controller.idFrontImageCedula == null)
                              const Icon(Icons.camera_alt, size: 50),
                            if (controller.idFrontImageCedula == null)
                              const Text('Cedula frontal')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Foto por delante de la tarjeta de identificación
                GestureDetector(
                  onTap: () async {
                    await controller.takeIdBackPhoto();
                    if (controller.idBackImageCedula != null) {
                      _.update();
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15), // Bordes redondeados
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (controller.idBackImageCedula != null)
                          Image.file(
                            controller.idBackImageCedula!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        if (controller.idBackImageCedula != null)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 40,
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (controller.idBackImageCedula == null)
                              const Icon(Icons.camera_alt, size: 50),
                            if (controller.idBackImageCedula == null)
                              const Text('Cedula posterior')
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20), // Espaciado entre filas
            // Fila 2: Fotos por detrás
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Foto por detrás de la licencia
                GestureDetector(
                  onTap: () async {
                    await controller.takeLicenseFrontPhoto();
                    if (controller.licenseFrontImage != null) {
                      _.update();
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15), // Bordes redondeados
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (controller.licenseFrontImage != null)
                          Image.file(
                            controller.licenseFrontImage!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        if (controller.licenseFrontImage != null)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 40,
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (controller.licenseFrontImage == null)
                              const Icon(Icons.camera_alt, size: 50),
                            if (controller.licenseFrontImage == null)
                              const CustomText(
                                text: "Licencia de conducion frontal",
                                fontFamily: "bold",
                                color: Colors.black,
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                // Foto por detrás de la tarjeta de identificación
                GestureDetector(
                  onTap: () async {
                    await controller.takeLicenseBackPhoto();
                    if (controller.licenseBackImage != null) {
                      _.update();
                    }
                  },
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15), // Bordes redondeados
                    ),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        if (controller.licenseBackImage != null)
                          Image.file(
                            controller.licenseBackImage!,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        if (controller.licenseBackImage != null)
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 40,
                          ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (controller.licenseBackImage == null)
                              const Icon(Icons.camera_alt, size: 50),
                            if (controller.licenseBackImage == null)
                              const CustomText(
                                text: "Licencia de conducion posterior",
                                fontFamily: "bold",
                                color: Colors.black,
                                textAlign: TextAlign.center,
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      );
    });
  }
}
