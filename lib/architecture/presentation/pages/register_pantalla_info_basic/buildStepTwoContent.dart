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
                child: Text(
                  "Información complementaria",
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
                CheckboxListTile(
                  title: const Row(
                    children: [
                      Icon(Icons.motorcycle_rounded,color: Colors.white), // Agrega el icono aquí
                      SizedBox(width: 8), // Un pequeño espacio entre el icono y el texto
                      Text(
                        'Categoría A2',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  value: controller.isCategoryA2Selected,
                  checkColor: Colors.black,
                  fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  onChanged: (value) {
                    controller.onCategorySelected(value!, 'A2');
                    controller.update(); // Actualizar la UI
                    if (value) {
                      _.fechaVigenciaA2.text = "";
                    }
                  },
                ),
                if (controller.showExpirationDateA2)
                  customTextFormField(
                    focusNode: fechaVigenciaA2Focus,
                    controller: _.fechaVigenciaA2,
                    hintText: 'Fecha de vigencia licencia A2',
                    prefixIcon: Icons.access_time_outlined,
                    onTap: () => _.showCalendarAndUpdateText(context, _.fechaVigenciaA2),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Este campo es requerido";
                      }
                    },
                    keyboardType: TextInputType.datetime,
                    onChanged: (value) {},
                  ),
                CheckboxListTile(
                  title: const Row(
                    children: [
                      Icon(Icons.directions_car_sharp,color: Colors.white), // Agrega el icono aquí
                      SizedBox(width: 8), // Un pequeño espacio entre el icono y el texto
                      Text(
                        'Categoría B1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  checkColor: Colors.black,
                  fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  value: controller.isCategoryB1Selected,
                  onChanged: (value) {
                    controller.onCategorySelected(value!, 'B1');
                    controller.update(); // Actualizar la UI
                    if (value) {
                      _.fechaVigenciaB1.text = "";
                    }
                  },
                ),
                if (controller.showExpirationDateB1)
                  customTextFormField(
                    focusNode: fechaVigenciaB1Focus,
                    controller: _.fechaVigenciaB1,
                    hintText: 'Fecha de vigencia licencia B1',
                    prefixIcon: Icons.access_time_outlined,
                    onTap: () => _.showCalendarAndUpdateText(context, _.fechaVigenciaB1),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Este campo es requerido";
                      }
                    },
                    keyboardType: TextInputType.datetime,
                    onChanged: (value) {},
                  ),
                CheckboxListTile(
                  title: const Row(
                    children: [
                      Icon(Icons.local_taxi_sharp,color: Colors.white),
                      SizedBox(width: 8), // Un pequeño espacio entre el icono y el texto
                      Text(
                        'Categoría C1',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  checkColor: Colors.black,
                  fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                  value: controller.isCategoryC1Selected,
                  onChanged: (value) {
                    controller.onCategorySelected(value!, 'C1');
                    controller.update(); // Actualizar la UI
                    if (value) {
                      _.fechaVigenciaC1.text = "";
                    }
                  },
                ),
                if (controller.showExpirationDateC1)
                  customTextFormField(
                    focusNode: fechaVigenciaC1Focus,
                    controller: _.fechaVigenciaC1,
                    hintText: 'Fecha de vigencia licencia C1',
                    prefixIcon: Icons.access_time_outlined,
                    onTap: () =>  _.showCalendarAndUpdateText(context, _.fechaVigenciaC1),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Este campo es requerido";
                      }
                    },
                    keyboardType: TextInputType.datetime,
                    onChanged: (value) {},
                  ),
            const SizedBox(height: 15),
            customTextFormField(
              focusNode: dateBirthFocus,
              controller: _.dateBirthController,
              hintText: 'Fecha de nacimiento',
              prefixIcon: Icons.date_range_rounded,
              onTap: () => _.showCalendarAndUpdateText(context, _.dateBirthController, field: 'dateBirth'),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Este campo es requerido";
                }
              },
              keyboardType: TextInputType.datetime,
              onChanged: (value) {},
            ),

            const SizedBox(height: 15),
            SizedBox(
              width: 320,
              child: ReusableDropdownFormField(
                labelText: 'Zona de cobertura',
                prefixIcon: Icons.add_box,
                options: controller.optionsCoverage,
                value: controller.optionsCoverageItemSelected.value,
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
              onChanged: (value) {},
            ),
          ],
        ),
      );
    });
  }
}
