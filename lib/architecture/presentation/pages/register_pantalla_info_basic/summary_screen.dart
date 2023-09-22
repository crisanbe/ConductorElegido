import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/register_controller/register_info_basic_controller.dart';

class SummaryScreen extends GetView<RegisterInfoBasicController> {
  const SummaryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterInfoBasicController>(builder: (_) {
      return Padding(
        padding: const EdgeInsets.all(16.0),
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
                  "Verifica tu informacion",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 7),
            _buildExpandingTile('Información Personal', [
              _buildInfoTile('Tipo de Documento', _.currentItemSelected.value),
              _buildInfoTile('Número de Documento', _.document.text),
              _buildInfoTile('Nombre Completo', _.fullName.text),
              _buildInfoTile('Contacto', _.contacto.text),
              _buildInfoTile('Correo Electrónico', _.email.text),
            ]),
            _buildExpandingTile('Información de Conductor', [
              _buildInfoTile('Contraseña', _.passwordController.text),
              _buildInfoTile('Estado', _.userStatus.toString()),
              _buildInfoTile('Fecha de Nacimiento', _.dateBirthController.text),
            ]),
            _buildExpandingTile('Vigencias', [
              _buildInfoTile('Fecha de Vigencia A2', _.fechaVigenciaA2.text),
              _buildInfoTile('Fecha de Vigencia B1', _.fechaVigenciaB1.text),
              _buildInfoTile('Fecha de Vigencia C1', _.fechaVigenciaC1.text),
            ]),
            _buildExpandingTile('Otra Información', [
              _buildInfoTile('Cobertura de Zona', _.optionsCoverageItemSelected.value),
              _buildInfoTile('Dirección', _.address.text),
            ]),
          ],
        ),
      );
    });
  }

  Widget _buildExpandingTile(String title, List<Widget> children) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ExpansionTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        children: children,
      ),
    );
  }

  Widget _buildInfoTile(String title, String value) {
    return ListTile(
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
      subtitle: Text(value),
    );
  }
}
