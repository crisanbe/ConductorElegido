import 'package:conductor_elegido/architecture/presentation/controllers/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../widgets/atomos/customText.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  Future<void> _refreshData() async {
    await controller.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            title: const Text("Conductor Activo!"),
          ),
          body: RefreshIndicator(
            onRefresh: _refreshData,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Container(
                color: Colors.white, // Cambiado a fondo blanco
                child: Center( // Añadido el Centro
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 300,
                        height: 300,
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
                              style: TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Colors.black, // Cambiado a texto negro
                              ),
                            ),
                            SizedBox(height: 10),
                            SizedBox(
                              width: 200,
                              child: CustomText(
                                text:
                                "The standard chunk of lorem Ipsum used since the 1500s is reproduced",
                                fontSize: 16,
                                color: Colors.black, // Cambiado a texto negro
                                fontFamily: "Arial",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Datos de Firebase:",
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.black, // Cambiado a texto negro
                        ),
                      ),
                      Obx(() {
                        if (_.isUserActive.value) {
                          return Text(
                            "Usuario Activo",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black, // Cambiado a texto negro
                            ),
                          );
                        } else if (_.isUserInRegistration.value) {
                          return Text(
                            "Usuario en Proceso de Registro",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black, // Cambiado a texto negro
                            ),
                          );
                        } else {
                          return Text(
                            "Otro Estado",
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black, // Cambiado a texto negro
                            ),
                          );
                        }
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              _.signOut();
              Obx(() {
                if (_.isSigningOut.value) {
                  return const CircularProgressIndicator();
                } else {
                  return const Text("Cerrar Sesión");
                }
              });
            },
            child: const Icon(Icons.logout),
          ),
        );
      },
    );
  }

}
