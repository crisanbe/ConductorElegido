import 'package:conductor_elegido/architecture/presentation/controllers/register_controller/register_info_basic_controller.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/moleculas/reusableDropdownFormField.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/moleculas/customtextformfield.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildStepTwoContent extends GetView<RegisterInfoBasicController> {
  const BuildStepTwoContent({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode dateBirthFocus = FocusNode();
    final FocusNode dateExpirationLicenseFocus = FocusNode();
    final FocusNode licensCurrentlyExpiredFocus = FocusNode();
    final FocusNode zoneCoverageFocus = FocusNode();
    final FocusNode addressFocus = FocusNode();
    return GetBuilder<RegisterInfoBasicController>(builder: (_) {
      return Form(
          key: _.formKey2,
          child: Column(
            children: [
              Container(
                width: 220,
                height: 220,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/information_complement.png'),
                  ),
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
                  child: Text("Información complementaria",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 15,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              customTextFormField(
                  focusNode: dateBirthFocus,
                  controller: _.dateBirthController,
                  hintText: 'Fecha de nacimiento',
                  prefixIcon: Icons.date_range_rounded,
                  onTap: ()=> _.showCalendarAndUpdateText(context,_.dateBirthController),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es requerido";
                    }
                  },
                  keyboardType: TextInputType.datetime,
                  onChanged: (value) {}),
              const SizedBox(height: 17),
              customTextFormField(
                  focusNode: dateExpirationLicenseFocus,
                  controller: _.dateExpirationLicense,
                  hintText: 'Fecha de expedicion licencia',
                  prefixIcon: Icons.account_box_rounded,
                  onTap: ()=> _.showCalendarAndUpdateText(context,_.dateExpirationLicense),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es requerido";
                    }
                  },
                  keyboardType: TextInputType.datetime,
                  onChanged: (value) {}),
              const SizedBox(height: 17),
              customTextFormField(
                  focusNode: licensCurrentlyExpiredFocus,
                  controller: _.licensCurrentlyExpired,
                  hintText: 'Fecha de vencimiento licencia',
                  prefixIcon: Icons.access_time_outlined,
                  onTap: ()=> _.showCalendarAndUpdateText(context,_.licensCurrentlyExpired),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Este campo es requerido";
                    }
                  },
                  keyboardType: TextInputType.datetime,
                  onChanged: (value) {}),
              const SizedBox(height: 15),
              SizedBox(
                width: 320,
                child: ReusableDropdownFormField(
                  labelText: 'Zona de cobertura',
                  prefixIcon: Icons.add_box,
                  options: controller.optionsCoverage,
                  value: controller.optionsCoverageItemSelected.value,
                  onChanged: (String? newValueSelected) {
                    controller.onRoleChanged(newValueSelected!);
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
                  focusNode: addressFocus,
                  controller: _.address,
                  hintText: 'Direccion',
                  prefixIcon: Icons.add_business_outlined,
                  validator: (value) {
                    RegExp regex = RegExp(r'^.{6,}$');
                    if (value!.isEmpty) {
                      return "La clave no puede estar vacía";
                    }
                  },
                  keyboardType: TextInputType.text,
                  onChanged: (value) {}),
              const SizedBox(height: 17),
            ],
          ));
    });
  }
}












