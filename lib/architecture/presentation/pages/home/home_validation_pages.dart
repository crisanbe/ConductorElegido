import 'package:conductor_elegido/architecture/presentation/controllers/home_controller.dart';
import 'package:conductor_elegido/architecture/presentation/pages/register/register_page.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/atomos/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeValidationPage extends GetView<HomeController> {
  const HomeValidationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("En validación.."),
        ),
        body: Container(
          color: Colors.black, // Fondo negro
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 300, // Ancho de la imagen aumentado
                height: 300, // Alto de la imagen aumentado
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/completet.png'),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Center(
                child: Column(
                  children: [
                    Text(
                      "Lorem Ipsum",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    SizedBox(
                      width: 200, // Establece el ancho del contenedor
                      child: CustomText(
                        text: "The standard chunk of lorem Ipsum used since the 1500s is reproduced",
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Arial",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              ),

            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
          onPressed: () {
            _.signOut();
            Get.to(() => const LoginPage());
            Obx(() {
              if (_.isSigningOut.value) {
                return const CircularProgressIndicator();
              } else {
                return const Text("Cerrar Sesión");
              }
            });
          },
          child: const Icon(Icons.logout, color: Colors.black,),
        ),
      );
    });
  }
}
