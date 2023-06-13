import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:run_app/ui/components/base_text.dart';

class ElementsData extends StatelessWidget {

  final String value;
  final String title;
  final String? icon;
  final Color? color;
  final double? sizeText;
  const ElementsData({
    Key? key,
    required this.value,
    required this.title,
    this.color = Colors.black,
    this.icon = "",
    this.sizeText = 15,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.only(right: 8, left: 8),
        child: Column(
          children: [
            BaseText(
              title: value,
              size: sizeText!,
              fontWeight: FontWeight.w500,
              color: color,
            ),
            Container(
              padding: const EdgeInsets.only(top: 8),
              child: Row(
                children: [
                  BaseText(
                    title: title,
                    size: sizeText!,
                    fontWeight: FontWeight.w300,
                    color: color,
                  ),
                  icon! != "" ? Padding(
                    padding: const EdgeInsets.only(left: 4),
                    child: SvgPicture.asset(
                      icon!,
                    ),
                  ) : const SizedBox(),
                ],
              ),
            )
          ],
        ),
      );
  }
}
