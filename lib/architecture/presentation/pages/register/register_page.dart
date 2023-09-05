import 'package:conductor_elegido/architecture/app/routes/app_pages.dart';
import 'package:conductor_elegido/architecture/presentation/controllers/gps_controller/Android/locationController.dart';
import 'package:conductor_elegido/architecture/presentation/controllers/login_controller.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';

class LoginPage extends GetView<RegisterController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (_) {
      final LocationController locationController = Get.put(LocationController());
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: const Color(0x410E0D0D),
        systemNavigationBarIconBrightness: Brightness.light,
      ));
      return Scaffold(
        backgroundColor:  Colors.black,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
             /* Obx(() {
                if (locationController.serviceEnabled.value) {
                  if (locationController.permissionGranted.value ==
                      PermissionStatus.granted) {
                    return ElevatedButton(
                      onPressed: () async {
                        await locationController.getCurrentLocation();
                        // Accede a la ubicación actual desde locationController.locationData
                      },
                      child: Text('Obtener Ubicación'),
                    );
                  } else {
                    return Text('Permiso de ubicación denegado');
                  }
                } else {
                  return Text('Servicio de ubicación deshabilitado');
                }
              }),*/
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),

                width: MediaQuery.of(context).size.width,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Form(
                    key: _.formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,

                      children: [
                        const SizedBox(
                          height: 80,
                        ),
                        Container(
                          width: 100, // Set the desired width for the logo
                          height: 100,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/splash.png'),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const SizedBox(
                          height: 50,
                        ),
                        SizedBox(
                          width: 300, // Ancho deseado para los campos de entrada
                          child: customTextFormField(
                            controller: _.emailController,
                            hintText: 'Correo electrónico',
                            keyboardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "El correo electrónico no puede estar vacío";
                              }
                              if (!RegExp(
                                  "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                  .hasMatch(value)) {
                                return ("Introduzca una dirección de correo electrónico válida");
                              } else {
                                return null;
                              }
                            },
                            onChanged: (value) {},
                            prefixIcon: Icons.email,
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Obx(() {
                          return SizedBox(
                            width: 300, // Ancho deseado para los campos de entrada
                            child: customTextFormField(
                              controller: _.passwordController,
                              hintText: 'Clave',
                              prefixIcon: Icons.password_sharp,
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return "La clave no puede estar vacía";
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("Introduzca una contraseña válida de 6 caracteres como mínimo");
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.text,
                              onChanged: (value) {},
                              obscureText: _.isObscure.value,
                              togglePasswordVisibility: () => _.togglePasswordVisibility(),
                              suffixIcon: _.isObscure.value ? Icons.visibility_off : Icons.visibility,
                            ),
                          );
                        }),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300, // Ancho deseado para los botones
                              child: MaterialButton(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0)),
                                  side: BorderSide(
                                      color: Colors.white), // Borde blanco
                                ),
                                elevation: 5.0,
                                height: 40,
                                onPressed: () {
                                  _.signIn();
                                },
                                color: Colors.black,
                                child: const Text(
                                  "Ingresar",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300, // Ancho deseado para los botones
                              child: MaterialButton(
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(10.0)),
                                  side: BorderSide(
                                      color: Colors.white), // Borde blanco
                                ),
                                elevation: 5.0,
                                height: 40,
                                onPressed: () {
                                  Get.toNamed(Routes.REGISTER);
                                },
                                color: Colors.black,
                                child: const Text(
                                  "Trabaja con nosotros",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 40),
                            child: Text(
                              "Olvidé mi clave",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                                color: Colors.yellowAccent[400],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
