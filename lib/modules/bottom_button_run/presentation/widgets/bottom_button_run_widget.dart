part of '../../bottom_button_run_part.dart';


class BottomButtonRunWidget extends StatefulWidget {
  final Function() OnClickInitialState;
  final Function() OnClickOpenMapState;
  final Function() OnClickRunState;

  const BottomButtonRunWidget({
    Key? key,
    required this.OnClickInitialState,
    required this.OnClickOpenMapState,
    required this.OnClickRunState,
  }) : super(key: key);

  @override
  State<BottomButtonRunWidget> createState() => _BottomButtonRunWidgetState();
}

class _BottomButtonRunWidgetState extends State<BottomButtonRunWidget>
    with SingleTickerProviderStateMixin {
  /*late AnimationController _controllerWidth;
  late Animation<double> _animationWidth;
  bool _isButtonPressed = false;

  @override
  void initState() {
    super.initState();
    _controllerWidth = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    startAnimationButtonRun(false);
  }

  void startAnimationButtonRun(bool state) {
    if (state) {
      _animationWidth = Tween<double>(begin: 1.5, end: 1).animate(_controllerWidth)
        ..addListener(() {
          setState(() {});
        });
    } else {
      _animationWidth = Tween<double>(begin: 1, end: 1.5).animate(_controllerWidth)
        ..addListener(() {
          setState(() {});
        });
    }
  }

  void _toggleButtonState() {
    if (_isButtonPressed) {
      startAnimationButtonRun(true);
      _controllerWidth.forward();
    } else {
      Future.delayed(const Duration(milliseconds: 500), () {
        startAnimationButtonRun(false);
        _controllerWidth.reverse();
      });
    }

    _isButtonPressed = !_isButtonPressed;
  }

  @override
  void dispose() {
    _controllerWidth.dispose();
    super.dispose();
  }
*/
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomButtonRunCubit, StateBottomButtonRun>(
        builder: (ctx, value) {
          return Container(
            padding: const EdgeInsets.only(bottom: 8),
            child: FloatingActionButton(
              onPressed: () {
                switch (value) {
                  case StateBottomButtonRun.initialState:
                    context.read<BottomButtonRunCubit>().switchOpenMapState();
                    widget.OnClickInitialState();

                    break;
                  case StateBottomButtonRun.openMapState:
                    context.read<BottomButtonRunCubit>().switchRunState();
                    widget.OnClickOpenMapState();

                   // _toggleButtonState();

                    break;
                  case StateBottomButtonRun.runState:
                    context.read<BottomButtonRunCubit>().switchOpenMapState();
                    widget.OnClickRunState();
                    context.router.push(const PostRunSurveyScreenRoute());


                   // _toggleButtonState();

                    break;
                }
              },
              child: SvgPicture.asset(
                  value == StateBottomButtonRun.initialState
                      ? "assets/icons/point_navigation.svg"
                      : value == StateBottomButtonRun.openMapState ? "assets/icons/play.svg" : "assets/icons/pause.svg",
                  color: Colors.black,
                  width: value == StateBottomButtonRun.runState ? 20 : 30,
                ),
            ),
          );
        });
  }
}
