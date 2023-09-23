import 'package:conductor_elegido/architecture/presentation/controllers/register_controller/register_info_basic_controller.dart';
import 'package:conductor_elegido/architecture/presentation/pages/loading/loading_page.dart';
import 'package:conductor_elegido/architecture/presentation/pages/register_pantalla_info_basic/buildStepOneContent.dart';
import 'package:conductor_elegido/architecture/presentation/pages/register_pantalla_info_basic/buildStepThreeCamara.dart';
import 'package:conductor_elegido/architecture/presentation/pages/register_pantalla_info_basic/buildStepTwoContent.dart';
import 'package:conductor_elegido/architecture/presentation/pages/register_pantalla_info_basic/summary_screen.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/atomos/customText.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/error_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterInfoBasicPage extends GetView<RegisterInfoBasicController> {
  const RegisterInfoBasicPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterInfoBasicController>(builder: (_) {
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: const Color(0x410E0D0D),
        systemNavigationBarIconBrightness: Brightness.light,
      ));

      List<Step> stepList() => [
        Step(
            state: controller.activeStepIndex.value <= 0
                ? StepState.editing
                : StepState.complete,
            isActive: controller.activeStepIndex.value >= 0,
            title: const Text(''),
            content: const BuildStepOneContent()),
        Step(
            state: controller.activeStepIndex.value <= 1
                ? StepState.editing
                : StepState.complete,
            isActive: controller.activeStepIndex.value >= 1,
            title: const Text(''),
            content: const BuildStepTwoContent()),
        Step(
          state: controller.activeStepIndex.value <= 2
              ? StepState.editing
              : StepState.complete,
          isActive: controller.activeStepIndex.value >= 2,
          title: const Text(''),
          content: const BuildStepThreeCamara(),
        ),
        Step(
          state: StepState.complete,
          isActive: controller.activeStepIndex.value >= 3,
          title: const Text(''),
          content: SummaryScreen()
        )
      ];

      return Container(
        padding: const EdgeInsets.only(top: 20.0),
        child: Scaffold(
          backgroundColor: Colors.black,//color de fondo de pantalla
          body: Obx(() {
            return Stack(
              children: [
                Theme(
                  data: ThemeData(canvasColor: Colors.black),
                  child: Stepper(
                    type: StepperType.horizontal,
                    currentStep: controller.activeStepIndex.value,
                    steps: stepList(),
                    onStepContinue: () {
                      controller.onNextStep(stepList());
                    },
                    onStepCancel: () {
                      controller.onPreviousStep();
                    },
                    onStepTapped: (int index) {controller.activeStepIndex.value = index;},
                    controlsBuilder: (BuildContext context, ControlsDetails controlsDetails) {
                      final isLastStep = controller.activeStepIndex.value == stepList().length - 1;
                      return Container(
                        color: Colors.black,
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: ()  async {
                                  bool isEmailRegistered = await controller.isEmailAlreadyRegistered(controller.email.text.trim());
                                  if (isLastStep) {
                                    if (controller.validateFields()) {
                                      // Validar correo electrónico
                                      if (isEmailRegistered) {
                                        Get.showSnackbar(const CustomSnackbar('Este correo electrónico ya está registrado.',icons: Icons.error_outline));
                                        return;
                                      }
                                      // Continuar con el registro si no hay errores
                                      _.signUp();
                                    } else {
                                      Get.showSnackbar(const CustomSnackbar('Por favor, completa todos los campos correctamente.',icons: Icons.error_outline));
                                    }
                                  } else {
                                    controlsDetails.onStepContinue!();
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: Colors.blueAccent,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    side: const BorderSide(color: Colors.white),
                                  ),
                                ),
                                child: (isLastStep) ? const Text('Enviar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                )
                                    : const Text('Continuar',
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            if (controller.activeStepIndex.value > 0)
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: controlsDetails.onStepCancel,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor: Colors.white,
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      side: const BorderSide(color: Colors.white),
                                    ),
                                  ),
                                  child: const CustomText(
                                    text: "Regresar",
                                    fontFamily: "bold",
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              )
                          ],
                        ),
                      );
                    },
                  ),
                ),
                if (controller.showProgressBar.value)
                const LoadingPage(message: "Enviando información...")
              ],
            );
          }),
        ),
      );
    });
  }
}
