import 'package:flutter/cupertino.dart';

class CustomText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final Color? color;
  final String? fontFamily;
  final TextAlign? textAlign;
  final int? maxLines; //  parámetro para controlar el número máximo de líneas
  final TextOverflow? overflow; //  parámetro para controlar el comportamiento de desbordamiento

  const CustomText({
    Key? key,
    required this.text,
    this.fontSize,
    this.color,
    this.fontFamily,
    this.textAlign,
    this.maxLines,
    this.overflow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // ancho al máximo disponible
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: fontFamily,
        ),
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: overflow,
      ),
    );
  }
}
