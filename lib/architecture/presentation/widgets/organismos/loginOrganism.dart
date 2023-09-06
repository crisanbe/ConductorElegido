import 'package:conductor_elegido/architecture/app/routes/app_pages.dart';
import 'package:conductor_elegido/architecture/app/ui/utils/strings.dart';
import 'package:conductor_elegido/architecture/app/ui/utils/utils.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/atomos/customText.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/moleculas/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginOrganism extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Function signIn;
  final bool isObscure;
  final Key formKey;
  final Function togglePasswordVisibility;

  const LoginOrganism({super.key,
    required this.emailController,
    required this.passwordController,
    required this.signIn,
    required this.togglePasswordVisibility,
    required this.isObscure, required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
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
        customTextFormField(
          controller: emailController,
          hintText: AppStrings.emailAddress,
          keyboardType: TextInputType.emailAddress,
          validator: validateEmail,
          onChanged: (value) {},
          prefixIcon: Icons.email,
        ),
        const SizedBox(height: 20),
          customTextFormField(
            controller: passwordController,
            hintText: AppStrings.password,
            prefixIcon: Icons.password_sharp,
            validator: validatePassword,
            keyboardType: TextInputType.text,
            onChanged: (value) {},
            obscureText: isObscure,
            togglePasswordVisibility:()=> togglePasswordVisibility(),
            suffixIcon: isObscure
                ? Icons.visibility_off
                : Icons.visibility,
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
                      color: Colors.white),
                ),
                elevation: 5.0,
                height: 40,
                onPressed: ()=> signIn(),
                color: Colors.black,
                child: const CustomText(
                  text: AppStrings.enter,
                  fontSize: 20.0,
                  color: Colors.white,
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
              width: 300,
              child: MaterialButton(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                      Radius.circular(10.0)),
                  side: BorderSide(color: Colors.white)),
                elevation: 5.0,
                height: 40,
                onPressed: () {
                  Get.toNamed(Routes.REGISTER);
                },
                color: Colors.black,
                child: const CustomText(
                  text: AppStrings.workwithus,
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.centerRight,
          child: Padding(
            padding: EdgeInsets.only(right: 40),
            child: CustomText(
              text: AppStrings.iforgotMypassword,
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(top: 200), // Agrega un espacio en la parte inferior
            child: CustomText(
              text: AppStrings.registerToday,
              fontSize: 15.0,
              color: Colors.white,
            ),
          ),
        )
      ],
    ));
  }
}