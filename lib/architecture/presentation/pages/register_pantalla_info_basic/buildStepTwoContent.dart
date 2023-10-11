import 'package:flutter/material.dart';
import 'package:conductor_elegido/architecture/presentation/controllers/register_controller/register_info_basic_controller.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/moleculas/reusableDropdownFormField.dart';
import 'package:conductor_elegido/architecture/presentation/widgets/moleculas/customtextformfield.dart';
import 'package:get/get.dart';

class BuildStepTwoContent extends GetView<RegisterInfoBasicController> {
  const BuildStepTwoContent({super.key});

  @override
  Widget build(BuildContext context) {
    final FocusNode dateBirthFocus = FocusNode();
    final FocusNode fechaVigenciaA2Focus = FocusNode();
    final FocusNode fechaVigenciaB1Focus = FocusNode();
    final FocusNode fechaVigenciaC1Focus = FocusNode();
    final FocusNode addressFocus = FocusNode();

    return GetBuilder<RegisterInfoBasicController>(builder: (_) {
      return Form(
        key: _.formKey2,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.topCenter,
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
                    'assets/images/information_complement.png',
                    fit: BoxFit.scaleDown,
                    width: 270, // Cambia el ancho según tus preferencias
                    height: 170,
                  ),
                ),
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
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
                    SizedBox(height: 7),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Text(
                          "",
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Theme(
              data: ThemeData(
                unselectedWidgetColor:
                Colors.white, // Color del borde del checkbox
              ),
              child: CheckboxListTile(
                title: const Row(
                  children: [
                    Icon(Icons.motorcycle_rounded, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Categoría A2',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                value: controller.isCategoryA2Selected,
                activeColor: Colors.blue,
                checkColor: Colors.black,
                onChanged: (value) {
                  controller.onCategorySelected(value!, 'A2');
                  controller.update(); // Actualizar la UI
                  if (value) {
                    _.fechaVigenciaA2.text = "";
                  }
                },
              ),
            ),
            if (controller.showExpirationDateA2)
              customTextFormField(
                focusNode: fechaVigenciaA2Focus,
                controller: _.fechaVigenciaA2,
                hintText: 'Fecha de vigencia licencia A2',
                prefixIcon: Icons.access_time_outlined,
                onTap: () =>
                    _.showCalendarAndUpdateText(context, _.fechaVigenciaA2),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Este campo es requerido";
                  }
                },
                keyboardType: TextInputType.datetime,
                onChanged: (value) {},
              ),
            Theme(
              data: ThemeData(
                unselectedWidgetColor:
                Colors.white, // Color del borde del checkbox
              ),
              child: CheckboxListTile(
                title: const Row(
                  children: [
                    Icon(Icons.directions_car_sharp, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Categoría B1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                activeColor: Colors.blue,
                checkColor: Colors.black,
                value: controller.isCategoryB1Selected,
                onChanged: (value) {
                  controller.onCategorySelected(value!, 'B1');
                  controller.update(); // Actualizar la UI
                  if (value) {
                    _.fechaVigenciaB1.text = "";
                  }
                },
              ),
            ),
            if (controller.showExpirationDateB1)
              customTextFormField(
                focusNode: fechaVigenciaB1Focus,
                controller: _.fechaVigenciaB1,
                hintText: 'Fecha de vigencia licencia B1',
                prefixIcon: Icons.access_time_outlined,
                onTap: () =>
                    _.showCalendarAndUpdateText(context, _.fechaVigenciaB1),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Este campo es requerido";
                  }
                },
                keyboardType: TextInputType.datetime,
                onChanged: (value) {},
              ),
            Theme(
              data: ThemeData(
                unselectedWidgetColor: Colors.white, // Color del borde del checkbox
              ),
              child: CheckboxListTile(
                title: const Row(
                  children: [
                    Icon(Icons.local_taxi_sharp, color: Colors.white),
                    SizedBox(width: 8),
                    Text(
                      'Categoría C1',
                      style: TextStyle(color: Colors.white),
                    ),
                  ],
                ),
                activeColor: Colors.blue,
                checkColor: Colors.black,
                value: controller.isCategoryC1Selected,
                onChanged: (value) {
                  controller.onCategorySelected(value!, 'C1');
                  controller.update(); // Actualizar la UI
                  if (value) {
                    _.fechaVigenciaC1.text = "";
                  }
                },
              ),
            ),
            if (controller.showExpirationDateC1)
              customTextFormField(
                focusNode: fechaVigenciaC1Focus,
                controller: _.fechaVigenciaC1,
                hintText: 'Fecha de vigencia licencia C1',
                prefixIcon: Icons.access_time_outlined,
                onTap: () =>
                    _.showCalendarAndUpdateText(context, _.fechaVigenciaC1),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Este campo es requerido";
                  }
                },
                keyboardType: TextInputType.datetime,
                onChanged: (value) {},
              ),
            SizedBox(height: 15),
            SizedBox(
              width: 320,
              child: ReusableDropdownFormField(
                labelText: 'Zona de cobertura',
                prefixIcon: Icons.add_box,
                options: controller.optionsCoverage,
                value: controller.optionsCoverageItemSelected.value,
                onChanged: (String? newValueSelected) {
                  controller.onCoverageChanged(newValueSelected!);
                },
                labelColor: Colors.white,
                enabledBorderColor: Colors.white,
                focusedBorderColor: Colors.white,
                errorBorderColor: Colors.amberAccent,
                dropdownColor: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            SizedBox(
              width: 320,
              child: ReusableDropdownFormField(
                labelText: 'EPS',
                prefixIcon: Icons.add_box,
                options: controller.optionsEps,
                value: controller.optionsEpsItemSelected.value,
                onChanged: (String? newValueSelected) {
                  controller.onEpsChanged(newValueSelected!);
                },
                labelColor: Colors.white,
                enabledBorderColor: Colors.white,
                focusedBorderColor: Colors.white,
                errorBorderColor: Colors.amberAccent,
                dropdownColor: Colors.white,
              ),
            ),
            SizedBox(height: 15),
            customTextFormField(
              focusNode: dateBirthFocus,
              controller: _.dateBirthController,
              hintText: 'Fecha de nacimiento',
              prefixIcon: Icons.date_range_rounded,
              onTap: () => _.showCalendarAndUpdateText(
                  context, _.dateBirthController,
                  field: 'dateBirth'),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Este campo es requerido";
                }
              },
              keyboardType: TextInputType.datetime,
              onChanged: (value) {},
            ),
            SizedBox(height: 15),
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
              onChanged: (value) {},
            ),
            SizedBox(height: 17),
          ],
        ),
      );
    });
  }
}
