import 'package:conductor_elegido/architecture/presentation/controllers/register_controller.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(builder: (_) {
      // Cambiar el color de la barra de estado y la barra de navegación
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
                      key: _.formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                image: AssetImage('assets/images/logo_conductor.png'),
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
                            width: 300,
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
                                prefixIcon: Icons.email),
                          ),
                          const SizedBox(height: 20,),
                          Obx(() {
                            return customTextFormField(
                                controller: _.passwordController,
                                hintText: 'Clave',
                                prefixIcon: Icons.password_sharp,
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
                                keyboardType: TextInputType.text,
                                onChanged: (value) {},
                                obscureText: _.isObscure.value,
                                togglePasswordVisibility: () => _.togglePasswordVisibility(),
                                suffixIcon: _.isObscure.value ? Icons.visibility_off : Icons.visibility);
                          }),
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
                                    _.signIn();
                                  },
                                  color: Colors.black,
                                  // Fondo oscuro
                                  child: const Text(
                                    "Ingresar",
                                    style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white, // Texto blanco
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
                                      _.signUp();
                                    },
                                    color: Colors.black,
                                    // Fondo oscuro
                                    child: const Text(
                                      "Trabaja con nosotros",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white, // Texto blanco
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
                              padding: const EdgeInsets.only(right: 40), // Ajusta según sea necesario
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
                          const Spacer(),
                          Text(
                            "Trabaja con nosotros",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              color: Colors.yellowAccent[400],
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
