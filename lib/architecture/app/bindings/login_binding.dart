import 'package:conductor_elegido/architecture/presentation/controllers/login_controller.dart';
import 'package:get/get.dart';

class LoginBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}