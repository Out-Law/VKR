import 'package:flutter/material.dart';
import 'package:run_app/modules/yandex_map/presentation/widgets/yandex_map_widget.dart';
import 'package:run_app/ui/screens/additional_screens/run_screen_information.dart';

enum StateRunScreen {
  map('map'),
  information("inform");

  final String value;

  const StateRunScreen(this.value);
}

class RunScreen extends StatefulWidget {
  const RunScreen({Key? key}) : super(key: key);

  @override
  State<RunScreen> createState() => _RunScreenState();
}


class _RunScreenState extends State<RunScreen>
    with SingleTickerProviderStateMixin{

  late AnimationController _animationController;
  late Animation<Offset> _animationOffset;
  var stateRunScreen = StateRunScreen.map;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animationOffset = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    ));
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YandexMapWidget(
          onOpenInformationRun: () {
            setState(() {
              stateRunScreen = StateRunScreen.information;
              _animationController.forward();
            });
          },
        ),
        SlideTransition(
          position: _animationOffset,
          child: Positioned(
            left: MediaQuery.of(context).size.width,
            top: 0,
            bottom: 0,
            width: MediaQuery.of(context).size.width,
            child: RunScreenInformation(
              onOpenMap: () {
                setState(() {
                  stateRunScreen = StateRunScreen.map;
                  _animationController.reverse();
                });
              },
            ),
          ),
        )
      ],
    );
  }
}
