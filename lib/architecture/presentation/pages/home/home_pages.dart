import 'package:conductor_elegido/architecture/presentation/controllers/home_controller.dart';
import 'package:conductor_elegido/architecture/presentation/pages/register/register_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_){
      return Scaffold(
        appBar: AppBar(
          title: const Text("Conductor Activo!"),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _.signOut();
            Obx(() {
              if (_.isSigningOut.value) {
                return const CircularProgressIndicator(); // Muestra un CircularProgressIndicator durante el cierre de sesión
              } else {
                return const Text("Cerrar Sesión");
              }
            }); // Llamada a la función de cierre de sesión desde el controlador.
          },
          child: const Icon(Icons.logout),
        ),
      );
    });
  }
}
