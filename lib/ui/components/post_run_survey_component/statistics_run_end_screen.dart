import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StatisticsRunEndScreen extends StatelessWidget {
  final AnimationController animationController;

  const StatisticsRunEndScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
        Tween<Offset>(begin: Offset(0, 1), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _secondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _textAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-2, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    final _imageAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-4, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.2,
          0.4,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );

    final _relaxAnimation =
        Tween<Offset>(begin: Offset(0, -2), end: Offset(0, 0)).animate(
      CurvedAnimation(
        parent: animationController,
        curve: Interval(
          0.0,
          0.2,
          curve: Curves.fastOutSlowIn,
        ),
      ),
    );
    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SlideTransition(
                  position: _relaxAnimation,
                  child: Text(
                    "Статистика забега",
                    style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SlideTransition(
                  position: _textAnimation,
                  child: const Padding(
                    padding:
                        EdgeInsets.only(left: 64, right: 64, top: 16, bottom: 16),
                    child: Text(
                      "Всего пробежал: 999\nВремя: 15:00:00\nКаллории: 1213",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SlideTransition(
                  position: _imageAnimation,
                  child: Container(
                    padding: EdgeInsets.only(top: 64),
                    constraints: BoxConstraints(maxWidth: 350, maxHeight: 250),
                    child: SvgPicture.asset(
                      "assets/icons/fire.svg",
                      width: 100,
                      height: 100,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
