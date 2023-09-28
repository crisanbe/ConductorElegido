import 'package:conductor_elegido/architecture/presentation/widgets/atomos/customText.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/home_controller.dart';

class HomeValidationPage extends GetView<HomeController> {
  const HomeValidationPage({Key? key}) : super(key: key);

  Future<void> _refreshData() async {
    await controller.refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (_) {
      return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.black,
          title: const Text("En validación.."),
        ),
        body: RefreshIndicator(
          onRefresh: _refreshData,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Container(
              color: Colors.black,
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
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: 200,
                          child: CustomText(
                            text:
                            "The standard chunk of lorem Ipsum used since the 1500s is reproduced",
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
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Datos de Firebase:",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  Obx(() {
                    if (_.isUserActive.value) {
                      return Text(
                        "Usuario Activo",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      );
                    } else if (_.isUserInRegistration.value) {
                      return Text(
                        "Usuario en Proceso de Registro",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      );
                    } else {
                      return Text(
                        "Otro Estado",
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      );
                    }
                  }),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.white,
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
          child: const Icon(Icons.logout, color: Colors.black,),
        ),
      );
    });
  }
}
