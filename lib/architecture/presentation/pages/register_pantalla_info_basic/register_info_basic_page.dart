import 'package:conductor_elegido/architecture/presentation/controllers/register_info_basic_controller.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterInfoBasicPage extends GetView<RegisterInfoBasicController> {
  const RegisterInfoBasicPage({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // Cambiar los iconos a blanco
      systemNavigationBarColor: const Color(0x410E0D0D),
      systemNavigationBarIconBrightness: Brightness.light,
    ));
    return Scaffold(
        backgroundColor: const Color(0x410E0D0D),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.symmetric(vertical: 30),
                color: const Color(0x411C1D25),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  child: Form(

                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [

                        Container(
                          width: 250, // Set the desired width for the logo
                          height: 250,
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage('assets/images/register.png'),
                            ),
                          ),
                        ),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 40), // Ajusta según sea necesario
                            child: Text(
                              "Trabaja con nostros",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(left: 40), // Ajusta según sea necesario
                            child: Text(
                              "Información básica",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Obx(() {
                          return SizedBox(
                            width: 300,
                            child: DropdownButtonFormField<String>(
                              decoration: const InputDecoration(
                                labelText: 'Tipo de documento',
                                labelStyle: TextStyle(color: Colors.white),
                                prefixIcon: Icon(Icons.document_scanner, color: Colors.white),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.amberAccent),
                                ),
                              ),
                              items: controller.options.map((String tipo) {
                                return DropdownMenuItem<String>(
                                  value: tipo,
                                  child: Container(
                                    decoration: BoxDecoration(
                                     shape: BoxShape.rectangle,
                                      color: Colors.white,
                                      borderRadius: BorderRadiusDirectional.horizontal()
                                    ),
                                    child: Text(
                                      tipo,
                                      style: const TextStyle(
                                        color: Colors.black,
                                        backgroundColor: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        decorationStyle: TextDecorationStyle.dotted,
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValueSelected) {
                                controller.onRoleChanged(newValueSelected!);
                              },
                              value: controller.currentItemSelected.value,
                              dropdownColor: Colors.white,
                            ),
                          );}),
                        const SizedBox(height: 20),
                           customTextFormField(
                              controller:  TextEditingController(text: ''),
                              hintText: 'Documento',
                              prefixIcon: Icons.document_scanner,
                              validator: (value) {
                                RegExp regex = RegExp(r'^.{6,}$');
                                if (value!.isEmpty) {
                                  return "La clave no puede estar vacía";
                                }
                                if (!regex.hasMatch(value)) {
                                  return ("introduzca una contraseña válida de 6 caracteres como mínimo");
                                } else {
                                  return null;
                                }
                              },
                              keyboardType: TextInputType.number,
                              onChanged: (value) {}),

                        const SizedBox(height: 20),
                        customTextFormField(
                            controller:  TextEditingController(text: ''),
                            hintText: 'Nombre completo/razon social',
                            prefixIcon: Icons.account_circle_outlined,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "La clave no puede estar vacía";
                              }
                              if (!regex.hasMatch(value)) {
                                return ("introduzca una contraseña válida de 6 caracteres como mínimo");
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            onChanged: (value) {}),

                        const SizedBox(height: 20),
                        customTextFormField(
                            controller:  TextEditingController(text: ''),
                            hintText: 'Contacto',
                            prefixIcon: Icons.contact_mail,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "La clave no puede estar vacía";
                              }
                              if (!regex.hasMatch(value)) {
                                return ("introduzca una contraseña válida de 6 caracteres como mínimo");
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            onChanged: (value) {}),

                        const SizedBox(height: 20),
                        customTextFormField(
                            controller:  TextEditingController(text: ''),
                            hintText: 'Correo eletronico',
                            prefixIcon: Icons.email,
                            validator: (value) {
                              RegExp regex = RegExp(r'^.{6,}$');
                              if (value!.isEmpty) {
                                return "La clave no puede estar vacía";
                              }
                              if (!regex.hasMatch(value)) {
                                return ("introduzca una contraseña válida de 6 caracteres como mínimo");
                              } else {
                                return null;
                              }
                            },
                            keyboardType: TextInputType.number,
                            onChanged: (value) {}),

                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 300, // Ancho deseado para el botón
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

                                },
                                color: Colors.black,
                                // Fondo oscuro
                                child: const Text(
                                  "Continuar",
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white, // Texto blanco
                                  ),
                                ),
                              ),
                            ),
                          ],
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
  }
}
