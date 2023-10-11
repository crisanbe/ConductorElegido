import 'package:conductor_elegido/architecture/app/ui/utils/utils.dart';
import 'package:conductor_elegido/architecture/presentation/controllers/register_controller/register_info_basic_controller.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/moleculas/reusableDropdownFormField.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/moleculas/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildStepOneContent extends GetView<RegisterInfoBasicController> {
  const BuildStepOneContent({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode documentFocus = FocusNode();
    final FocusNode fullNameFocus = FocusNode();
    final FocusNode contactoFocus = FocusNode();
    final FocusNode emailFocus = FocusNode();
    final FocusNode passwordFocus = FocusNode();
    return GetBuilder<RegisterInfoBasicController>(builder: (_) {
     return Center(
        child: Form(
          key: _.formKey,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(15.0), // Bordes redondeados
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2), // Sombra sutil
                      spreadRadius: 2,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Image.asset(
                  'assets/images/register.png',
                  fit: BoxFit.cover,
                  width: 170,
                  height: 170,
                ),
              ),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text(
                    "Trabaja con nosotros",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 7),
              const Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 40),
                  child: Text("Información básica",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              SizedBox(
                width: 320,
                child: ReusableDropdownFormField(
                  labelText: 'Tipo de documento',
                  prefixIcon: Icons.document_scanner,
                  options: controller.options,
                  value: controller.currentItemSelected.value,
                  onChanged: (String? newValueSelected) {
                    controller.onDocumentChanged(newValueSelected!);
                  },
                  labelColor: Colors.white,
                  enabledBorderColor: Colors.white,
                  focusedBorderColor: Colors.white,
                  errorBorderColor: Colors.amberAccent,
                  dropdownColor: Colors.white,
                ),
              ),
              const SizedBox(height: 17),
              customTextFormField(
                  focusNode: documentFocus,
                  controller: _.document,
                  hintText: 'Documento',
                  prefixIcon: Icons.document_scanner,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return "Este campo es requerido";
                    }
                    if (!regex.hasMatch(value)) {
                      return ("introduzca una cedula válida de 6 caracteres como mínimo");
                    } else {
                      return null;
                    }
                  },
                  keyboardType: TextInputType.number,
                  onChanged: (value) {}),
              const SizedBox(height: 17),
              customTextFormField(
                focusNode: fullNameFocus,
                controller: _.fullName,
                hintText: 'Nombre completo/razon social',
                prefixIcon: Icons.account_circle_outlined,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Este campo es requerido";
                  }
                },
                keyboardType: TextInputType.text,
                onChanged: (value) {},
              ),

              const SizedBox(height: 17),
              customTextFormField(
                  focusNode: contactoFocus,
                  controller: _.contacto,
                  hintText: 'Contacto',
                  prefixIcon: Icons.contact_mail,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es requerido";
                    }
                  },
                  keyboardType: TextInputType.number,
                  onChanged: (value) {}),
              const SizedBox(height: 17),
              customTextFormField(
                  focusNode: emailFocus,
                  controller: _.email,
                  hintText: 'Correo eletronico',
                  prefixIcon: Icons.email,
                  validator: validateEmail,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {}),
              const SizedBox(height: 17),
              Obx(() {
                return customTextFormField(
                  focusNode: passwordFocus,
                  controller: _.passwordController,
                  hintText: 'clave',
                  prefixIcon: Icons.email,
                  validator: validatePassword,
                  keyboardType: TextInputType.text,
                  onChanged: (value) {},
                  obscureText: _.isObscure.value,
                  togglePasswordVisibility:()=> _.togglePasswordVisibility(),
                  suffixIcon: _.isObscure.value
                      ? Icons.visibility_off
                      : Icons.visibility,
                );
              }),
              const SizedBox(height: 17),
            ],
          ),
        ),
      );
    });
  }
}












