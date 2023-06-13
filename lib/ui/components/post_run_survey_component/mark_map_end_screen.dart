import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:run_app/modules/yandex_map/presentation/widgets/yandex_map_widget.dart';
import 'package:run_app/ui/components/base_switcher.dart';

class MarkMapEndScreen extends StatelessWidget {
  final AnimationController animationController;

  const MarkMapEndScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _secondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _relaxFirstHalfAnimation =
        Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _relaxSecondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-2, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _imageFirstHalfAnimation =
        Tween<Offset>(begin: Offset(4, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.2,
        0.4,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _imageSecondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-4, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100, left: 16, right: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SlideTransition(
                position: _relaxFirstHalfAnimation,
                child: SlideTransition(
                  position: _relaxSecondHalfAnimation,
                  child: const Text(
                    "Отмечайте на карте возникшие трудности",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: SlideTransition(
                  position: _imageFirstHalfAnimation,
                  child: SlideTransition(
                    position: _imageSecondHalfAnimation,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        constraints: BoxConstraints(maxWidth: 350, maxHeight: 250),
                        child: YandexMapWidget(
                          visRunData: false,
                          onOpenInformationRun: () {

                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: BaseSlideSwitcher(
                  onSelect: (int index) {
                    if (index == 0) {

                    } else if (index == 1) {

                    } else if (index == 2){

                    }
                  },
                  indents: 4,
                  containerHeight: 50,
                  containerWight: 235,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/fi-br-paw.svg",
                      color: Colors.black,
                    ),
                    SvgPicture.asset(
                      "assets/icons/fi-br-bulb.svg",
                      color: Colors.black,
                    ),
                    SvgPicture.asset(
                      "assets/icons/fi-br-chart-pyramid.svg",
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
