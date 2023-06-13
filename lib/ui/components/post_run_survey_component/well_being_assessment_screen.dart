import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WellBeingAssessmentScreen extends StatelessWidget {
  final AnimationController animationController;

  const WellBeingAssessmentScreen({Key? key, required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _firstHalfAnimation =
        Tween<Offset>(begin: Offset(1, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: const Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _secondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-1, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    final _moodFirstHalfAnimation =
        Tween<Offset>(begin: Offset(2, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _moodSecondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-2, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _imageFirstHalfAnimation =
        Tween<Offset>(begin: Offset(4, 0), end: Offset(0, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.4,
        0.6,
        curve: Curves.fastOutSlowIn,
      ),
    ));
    final _imageSecondHalfAnimation =
        Tween<Offset>(begin: Offset(0, 0), end: Offset(-4, 0))
            .animate(CurvedAnimation(
      parent: animationController,
      curve: Interval(
        0.6,
        0.8,
        curve: Curves.fastOutSlowIn,
      ),
    ));

    return SlideTransition(
      position: _firstHalfAnimation,
      child: SlideTransition(
        position: _secondHalfAnimation,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Как вы себя чувствуете?",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 26.0, fontWeight: FontWeight.bold),
                ),
                SlideTransition(
                  position: _imageFirstHalfAnimation,
                  child: SlideTransition(
                    position: _imageSecondHalfAnimation,
                    child: Container(
                      constraints: BoxConstraints(maxWidth: 350),
                      child: MoodSliderColumn(),
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


class MoodSliderColumn extends StatefulWidget {
  @override
  _MoodSliderColumnState createState() => _MoodSliderColumnState();
}

class _MoodSliderColumnState extends State<MoodSliderColumn> {
  double _moodValue = 70;
  String _moodIcon = "assets/icons/Emoji4.svg";

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Slider(
          value: _moodValue,
          onChanged: (newValue) {
            setState(() {
              _moodValue = newValue;
              if (_moodValue < 20) {
                _moodIcon = "assets/icons/Emoji1.svg";
              } else if (_moodValue < 40) {
                _moodIcon = 'assets/icons/Emoji2.svg';
              }
              else if (_moodValue < 60) {
                _moodIcon = 'assets/icons/Emoji3.svg';
              }
              else if (_moodValue < 80) {
                _moodIcon = 'assets/icons/Emoji4.svg';
              } else {
                _moodIcon = 'assets/icons/Emoji5.svg';
              }
            });
          },
          min: 0.0,
          max: 100.0,
          divisions: 10,
          label: '${_moodValue.round()}',
        ),
        SizedBox(height: 16.0),
        SvgPicture.asset(
          _moodIcon,
          color: Colors.amberAccent,
          width: 100,
          height: 100,
        ),
        SizedBox(height: 16.0),
        Text(
          "Настроение: ${_moodValue.round()}",
          style: TextStyle(fontSize: 20.0),
        ),
      ],
    );
  }
}
