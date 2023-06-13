import 'package:flutter/material.dart';

class BaseBackgroundContainer extends StatelessWidget {
  final Color color;
  final Widget child;
  final EdgeInsetsGeometry? margin;

  const BaseBackgroundContainer(
      {Key? key, required this.color, required this.child, this.margin})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: margin,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: child,
    );
  }
}
