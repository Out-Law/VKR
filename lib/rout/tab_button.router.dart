import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:run_app/modules/reg_log_module/entities/state_reg_log.dart';
import 'package:run_app/modules/reg_log_module/presentation/bloc/state_reg_log_cubit.dart';
import 'package:run_app/modules/bottom_button_run/bottom_button_run_part.dart';
import 'package:run_app/modules/timer/entities/timer_event.dart';
import 'package:run_app/modules/timer/presentation/bloc/timer_cubit.dart';
import 'package:run_app/rout/app_rout.gr.dart';

class BottomNavigationPage extends StatefulWidget {
  const BottomNavigationPage({Key? key}) : super(key: key);

  @override
  State<BottomNavigationPage> createState() => _BottomNavigationPageState();
}

class _BottomNavigationPageState extends State<BottomNavigationPage>
    with TickerProviderStateMixin {

  late AnimationController _fabAnimationController;
  late AnimationController _borderRadiusAnimationController;
  late Animation<double> fabAnimation;
  late Animation<double> borderRadiusAnimation;
  late CurvedAnimation fabCurve;
  late CurvedAnimation borderRadiusCurve;
  late AnimationController _hideBottomBarAnimationController;

  final iconList = <String>[
    "assets/icons/chempion.svg",
    "assets/icons/persona.svg"
  ];

  @override
  void initState() {
    super.initState();
    _fabAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    _borderRadiusAnimationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    fabCurve = CurvedAnimation(
      parent: _fabAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );
    borderRadiusCurve = CurvedAnimation(
      parent: _borderRadiusAnimationController,
      curve: const Interval(0.5, 1.0, curve: Curves.fastOutSlowIn),
    );

    fabAnimation = Tween<double>(begin: 0, end: 1).animate(fabCurve);
    borderRadiusAnimation = Tween<double>(begin: 0, end: 1).animate(
      borderRadiusCurve,
    );

    _hideBottomBarAnimationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    Future.delayed(
      const Duration(seconds: 1),
          () => _fabAnimationController.forward(),
    );
    Future.delayed(
      const Duration(seconds: 1),
          () => _borderRadiusAnimationController.forward(),
    );
  }

  ///Реализация скрытие меню при скролинге
/*  bool onScrollNotification(ScrollNotification notification) {
    if (notification is UserScrollNotification &&
        notification.metrics.axis == Axis.vertical) {
      switch (notification.direction) {
        case ScrollDirection.forward:
          _hideBottomBarAnimationController.reverse();
          _fabAnimationController.forward(from: 0);
          break;
        case ScrollDirection.reverse:
          _hideBottomBarAnimationController.forward();
          _fabAnimationController.reverse(from: 1);
          break;
        case ScrollDirection.idle:
          break;
      }
    }
    return false;
  }*/

  ///Реализация скрытия при переходе на карту
  bool onTapAnimate(bool state) {
    if (state) {
      _hideBottomBarAnimationController.reverse();
      _fabAnimationController.forward(from: 0);
    }
    else{
      _hideBottomBarAnimationController.forward();
      _fabAnimationController.reverse(from: 1);
    }
    return false;
  }

 @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        resizeToAvoidBottomInset: false,
        routes: const [
          MainScreenRoute(),
          RacesScreenRoute(),
          RunScreenRoute(),
        ],
        floatingActionButtonBuilder: (_, tabsRouter){
          return BlocBuilder<StateRegLogCubit, StateRegLog>(
              builder: (ctx, value) {
            return Visibility(
              visible: value == StateRegLog.application || value == StateRegLog.noRegistration,
              child: BottomButtonRunWidget(
                OnClickInitialState: () {
                  tabsRouter.setActiveIndex(2);
                },
                OnClickOpenMapState: () {
                  onTapAnimate(false);
                  context.read<TimerCubit>().handleEvent(
                      Start(
                          hours: 0,
                          minutes: 0,
                          seconds: 0
                      )
                  );
                },
                OnClickRunState: () {
                  context.read<TimerCubit>().handleEvent(Stop());
                  Future.delayed(const Duration(milliseconds: 500), () {
                    onTapAnimate(true);
                  });
                },
              ),
            );
          });
        },
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBuilder: (_, tabsRouter) {
          return BlocBuilder<StateRegLogCubit, StateRegLog>(
          builder: (ctx, value) {
            return Visibility(
              visible: value == StateRegLog.application,
              child: AnimatedBottomNavigationBar.builder(
                itemCount: iconList.length,
                tabBuilder: (int index, bool isActive) {
                  final color = isActive ?
                  Theme.of(context).primaryColor : Colors.white;
                  return SvgPicture.asset(
                    iconList[index],
                    color: color,
                  );
                },
                backgroundColor: const Color(0xff646464),
                activeIndex: tabsRouter.activeIndex,
                notchAndCornersAnimation: borderRadiusAnimation,
                splashSpeedInMilliseconds: 300,
                notchSmoothness: NotchSmoothness.softEdge,
                gapLocation: GapLocation.center,
                leftCornerRadius: 32,
                rightCornerRadius: 32,
                onTap: (index) {
                  context.read<BottomButtonRunCubit>().switchInitialState();
                  setState(() => tabsRouter.setActiveIndex(index));
                },
                hideAnimationController: _hideBottomBarAnimationController,
              ),
            );
          });
        });
  }
}
