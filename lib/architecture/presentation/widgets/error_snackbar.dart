import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// Show a red snackbar with the error information.
class CustomSnackbar extends GetSnackBar {
  final String message;
  final Color? backgroundColors;
  final Color? textColor;
  final IconData? icons;

  const CustomSnackbar(
      this.message, {
        this.backgroundColors,
        this.textColor,
        this.icons,
        Key? key,
      }) : super(key: key);

  @override
  Color get backgroundColor => backgroundColors ?? Colors.redAccent;

  @override
  Widget? get icon => icons != null ? Icon(icons, color: Colors.white) : null;

  @override
  Widget? get mainButton {
    return IconButton(
      onPressed: () => Get.back(),
      icon: const Icon(Icons.close_outlined, color: Colors.white),
    );
  }

  @override
  // TODO: implement duration
  Duration? get duration => const Duration(seconds: 3);

  @override
  Widget? get messageText {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: SelectableText(
        message,
        style: TextStyle(
          color: textColor ?? Colors.white,
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
    );
  }

  @override
  SnackPosition get snackPosition => SnackPosition.TOP;
}