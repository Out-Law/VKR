import 'package:flutter/material.dart';

class BaseText extends StatelessWidget {
  final String title;
  final double size;
  final FontWeight? fontWeight;
  final String? fontFamily;
  final Color? color;
  const BaseText({
    Key? key,
    required this.title,
    required this.size,
    this.fontWeight = FontWeight.w700,
    this.fontFamily = "Montserrat",
    this.color = const Color(0xff222222),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
          inherit: false,
          color: color,
          fontWeight: fontWeight,
          fontSize: size,
          fontFamily: fontFamily,
      ),
    );
  }
}
