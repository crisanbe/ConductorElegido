import 'package:conductor_elegido/architecture/presentation/controllers/register_controller.dart';
import 'package:conductor_elegido/architecture/presentation/controllers/register_info_basic_controller.dart';
import 'package:get/get.dart';

class RegisterInfoBasicBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RegisterInfoBasicController>(() => RegisterInfoBasicController());
  }
}