import 'package:conductor_elegido/architecture/domain/repositories/user_repository_impl.dart';
import 'package:conductor_elegido/architecture/domain/use_cases/sing_up_usecase.dart';
import 'package:conductor_elegido/architecture/presentation/pages/home/home_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RegisterInfoBasicController extends GetxController {

  List<String> options = [
    'CC',
    'Documento 2'
  ];
  RxString currentItemSelected = "CC".obs;

   onRoleChanged(String newValue) {
    currentItemSelected.value = newValue;
  }

}

