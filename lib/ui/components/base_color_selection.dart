import 'package:flutter/material.dart';

class BaseColorSelection extends StatelessWidget {
  final bool choiceThemeColors;
  final int choiceColor;
  final Function(int index) onTap;
  const BaseColorSelection({
    Key? key,
    required this.choiceThemeColors,
    required this.onTap,
    required this.choiceColor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<Color> colorsLight = const [
      Color(0xFFA9C8F2),
      Color(0xFFFF6F61),
      Color(0xFF5EB95C),
    ];

    List<Color> colorsBlack = const [
      Color(0xFF658FC9),
      Color(0xFF5EB95C),
      Color(0xFF4BB848),
    ];

    return SizedBox(
      width: 200,
      height: 50,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (BuildContext context, int index) {
            return GestureDetector(
              onTap: (){
                onTap(index);
              },
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(25)),
                    border: Border.all(
                        color: choiceColor == index ? const Color(0xFFBBBBBB)
                            : Theme.of(context).scaffoldBackgroundColor,
                        width: 3
                    ),
                    color: Theme.of(context).scaffoldBackgroundColor
                ),
                child: Stack(
                  alignment: AlignmentDirectional.center,
                  children: [
                    Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(Radius.circular(25)),
                          color: Color(
                              choiceThemeColors ? colorsLight[index].value
                                  : colorsBlack[index].value
                          )
                        )
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
