import 'package:conductor_elegido/architecture/app/bindings/home_binding.dart';
import 'package:conductor_elegido/architecture/app/bindings/register_binding.dart';
import 'package:conductor_elegido/architecture/app/bindings/register_info_basic_binding.dart';
import 'package:conductor_elegido/architecture/app/bindings/splash_binding.dart';
import 'package:conductor_elegido/architecture/presentation/pages/home/home_pages.dart';
import 'package:conductor_elegido/architecture/presentation/pages/register/register_page.dart';
import 'package:conductor_elegido/architecture/presentation/pages/register_pantalla_info_basic/register_info_basic_page.dart';
import 'package:conductor_elegido/architecture/presentation/pages/splash/splash_screen.dart';
import 'package:get/get.dart';
part 'app_routes.dart';

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.INITIAL,
      page: () =>  const SplashPage(),
      transition: Transition.native,
      binding: SplashBinding()
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () =>  const RegisterPage(),
      transition: Transition.native,
      binding: RegisterBinding()
    ),
    GetPage(
        name: Routes.REGISTER1,
        page: () =>  const RegisterInfoBasicPage(),
        transition: Transition.native,
        binding: RegisterInfoBasicBinding()
    ),
    GetPage(
        name: Routes.HOME,
        page: () =>  const HomePage(),
        transition: Transition.native,
        binding: HomeBinding()
    )
  ];
}