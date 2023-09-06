import 'package:conductor_elegido/architecture/presentation/controllers/login_controller.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/organismos/loginOrganism.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(builder: (_) {
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
          Obx(() {
              return LoginOrganism(
                formKey: _.formKey,
                emailController: _.emailController,
                passwordController: _.passwordController,
                signIn: () => _.signIn(),
                isObscure: _.isObscure.value,
                togglePasswordVisibility: () => _.togglePasswordVisibility(),
              );
             }),
            ],
          ),
        ),
      );
    });
  }
}