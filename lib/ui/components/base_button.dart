import 'package:flutter/material.dart';
import 'package:run_app/ui/components/base_text.dart';

class BaseButton extends StatelessWidget {
  final Function() onClick;
  final String title;
  final bool active;
  final bool? activeBorder;
  final double sizeText;
  final Color? color;
  final Color? colorText;
  const BaseButton({
    Key? key,
    required this.onClick,
    required this.title,
    required this.active,
    required this.sizeText,
    this.color = const Color(0xff00B1B3),
    this.colorText = const Color(0xff222222),
    this.activeBorder = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
        backgroundColor: active == true ? color : const Color(0xffffffff),
        onPressed: () {
          onClick();
        },
        label: Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(left: 32, right: 32, top:  12, bottom: 12),
            child: BaseText(
                title: title,
                size: sizeText,
                color: colorText,
            ),
          )
        ),
      shape: activeBorder! ?  StadiumBorder(side: BorderSide(width: 2, color: color!)) : const StadiumBorder(side: BorderSide(width: 0, color: Colors.transparent))
    );
  }
}
