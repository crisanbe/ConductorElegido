import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

Widget customTextFormField({
  bool obscureText = false,
  TextEditingController? controller,
  String hintText = '',
  String? Function(String?)? validator,
  Function(String)? onChanged,
  Function()? onTap,
  TextInputType? keyboardType,
  IconData? prefixIcon,
  IconData? suffixIcon,
  FocusNode? focusNode, // Agrega el FocusNode como parámetro
  VoidCallback? togglePasswordVisibility,
}) {
  return Container(
    width: 320,
    child: TextFormField(
      onTap: onTap,
      obscureText: obscureText,
      controller: controller,
      focusNode: focusNode, // Asigna el FocusNode al TextFormField
      decoration: InputDecoration(
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        suffixIcon: suffixIcon != null ? IconButton(
          icon: Icon(suffixIcon),
          onPressed: togglePasswordVisibility,
        ) : null,
        filled: true,
        fillColor: Colors.white,
        hintText: hintText,
        enabled: true,
        contentPadding:
        const EdgeInsets.only(left: 14.0, bottom: 8.0, top: 15.0),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
        enabledBorder: UnderlineInputBorder(
          borderSide: const BorderSide(color: Colors.white),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      keyboardType: keyboardType,
      validator: validator,
      onChanged: onChanged,
    ),
  );
}
