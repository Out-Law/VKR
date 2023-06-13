import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:run_app/modules/yandex_map/presentation/bloc/marker_discomfort_cubit.dart';

class AnimatedButton extends StatefulWidget {
  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with TickerProviderStateMixin {
  late AnimationController _animationController;

  bool _isExpanded = false;
  bool dengarButton = false;
  bool dogButton = false;
  bool lightButton = false;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AnimatedContainer(
          duration: Duration(milliseconds: 500),
          width: _isExpanded ? 260.0 : 60.0,
          height: 60.0,
          child: Stack(
            children: [
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.linear,
                left: 0.0,
                top: 0.0,
                child: buttonNavigation(
                    icon: "assets/icons/fi-br-bulb.svg",
                    onClick: () {
                      context.read<AdditionalPointYaMapCubit>().visGroupObjects(TypeMarker.noLight);
                      setState(() {
                        lightButton= !lightButton;
                      });
                    },
                    station: lightButton
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.linear,
                left: _isExpanded ? 68.0 : 0.0,
                top: 0.0,
                child: buttonNavigation(
                    icon: "assets/icons/fi-br-chart-pyramid.svg",
                    onClick: () {
                      context.read<AdditionalPointYaMapCubit>().visGroupObjects(TypeMarker.danger);
                      setState(() {
                        dengarButton = !dengarButton;
                      });
                    },
                    station: dengarButton
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 500),
                curve: Curves.linear,
                left: _isExpanded ? 134.0 : 0.0,
                top: 0.0,
                child: buttonNavigation(
                    icon: "assets/icons/fi-br-paw.svg",
                    onClick: () {
                      context.read<AdditionalPointYaMapCubit>().visGroupObjects(TypeMarker.dogs);
                      setState(() {
                        dogButton = !dogButton;
                      });
                    },
                    station: dogButton
                ),
              ),
              Positioned(
                      right: 0.0,
                      top: 0.0,
                      child: Container(
                        width: 60,
                        height: 60,
                        decoration: BoxDecoration(
                            color: lightButton ||dengarButton ||dogButton
                            ? Color(0xff3379D9): Colors.white,
                            borderRadius: const BorderRadius.all(Radius.circular(5))),
                        child: GestureDetector(
                          onTap: (){
                            setState(() {
                              if (_isExpanded) {
                                _animationController.reverse();
                              } else {
                                _animationController.forward();
                              }
                              _isExpanded = !_isExpanded;
                            });
                          },
                          child: Padding(
                            padding: EdgeInsets.all(12),
                            child: SvgPicture.asset(
                                "assets/icons/fi-br-map-marker.svg",
                              width: 22,
                              height: 28,
                              color: lightButton ||dengarButton ||dogButton
                                  ? Colors.white : Color(0xff3379D9),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  Widget buttonNavigation({double? top = 0, double? button = 0, required String icon, required Function() onClick, required bool station}){
    return GestureDetector(
      onTap: () { onClick(); },
      child: Container(
        height: 60,
        width: 60,
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              width: 2.0,
              color: station
                  ? Color(0xff3379D9)
                  : Colors.transparent,
            ),
            borderRadius:  BorderRadius.all(Radius.circular(5))
        ),
        child: Container(
          padding: EdgeInsets.all(14),
          child: SvgPicture.asset(
            icon,
            color: station ?  Color(0xff3379D9) : Colors.black,
          ),
        ),
      ),
    );
  }
}
