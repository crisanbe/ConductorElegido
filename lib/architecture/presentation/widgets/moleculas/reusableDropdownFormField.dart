import 'package:flutter/material.dart';

class ReusableDropdownFormField extends StatelessWidget {
  final String labelText;
  final IconData prefixIcon;
  final List<String> options;
  final String? value;
  final Function(String?) onChanged;
  final Color labelColor;
  final Color enabledBorderColor;
  final Color focusedBorderColor;
  final Color errorBorderColor;
  final Color dropdownColor;

  const ReusableDropdownFormField({super.key,
    required this.labelText,
    required this.prefixIcon,
    required this.options,
    required this.value,
    required this.onChanged,
    this.labelColor = Colors.white,
    this.enabledBorderColor = Colors.white,
    this.focusedBorderColor = Colors.white,
    this.errorBorderColor = Colors.amberAccent,
    this.dropdownColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(color: labelColor),
        prefixIcon: Icon(prefixIcon, color: labelColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: enabledBorderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: focusedBorderColor),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: errorBorderColor),
        ),
      ),
      items: options.map((String tipo) {
        return DropdownMenuItem<String>(
          value: tipo,
          child: Container(
            decoration: const BoxDecoration(
              shape: BoxShape.rectangle,
              color: Colors.white,
              borderRadius: BorderRadius.horizontal(),
            ),
            child: Text(
              tipo,
              style: const TextStyle(
                color: Colors.black,
                backgroundColor: Colors.white,
                fontWeight: FontWeight.bold,
                decorationStyle: TextDecorationStyle.dotted,
              ),
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      value: value,
      dropdownColor: dropdownColor,
    );
  }
}
