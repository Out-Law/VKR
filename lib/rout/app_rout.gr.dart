// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;

import '../modules/races_events/entities/race_event_state.dart' as _i11;
import '../ui/screens/additional_screens/create_race_screen.dart' as _i4;
import '../ui/screens/additional_screens/post_run_survey_screen.dart' as _i3;
import '../ui/screens/additional_screens/settings_screen.dart' as _i2;
import '../ui/screens/main/main_screen.dart' as _i6;
import '../ui/screens/main/races_screen.dart' as _i8;
import '../ui/screens/main/run_screen_map.dart' as _i7;
import '../ui/screens/reg_log_screens/login_screen.dart' as _i5;
import 'tab_button.router.dart' as _i1;

class AppRouter extends _i9.RootStackRouter {
  AppRouter([_i10.GlobalKey<_i10.NavigatorState>? navigatorKey])
      : super(navigatorKey);

  @override
  final Map<String, _i9.PageFactory> pagesMap = {
    RootRouter.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i1.BottomNavigationPage(),
      );
    },
    SettingsScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i2.SettingsScreen(),
      );
    },
    PostRunSurveyScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i3.PostRunSurveyScreen(),
      );
    },
    CreateRaceScreenRoute.name: (routeData) {
      final args = routeData.argsAs<CreateRaceScreenRouteArgs>(
          orElse: () => const CreateRaceScreenRouteArgs());
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: _i4.CreateRaceScreen(
          key: args.key,
          raceEvent: args.raceEvent,
        ),
      );
    },
    LoginScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i5.LoginScreen(),
      );
    },
    MainScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i6.MainScreen(),
      );
    },
    RunScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i7.RunScreen(),
      );
    },
    RacesScreenRoute.name: (routeData) {
      return _i9.MaterialPageX<dynamic>(
        routeData: routeData,
        child: const _i8.RacesScreen(),
      );
    },
  };

  @override
  List<_i9.RouteConfig> get routes => [
        _i9.RouteConfig(
          RootRouter.name,
          path: '/',
          children: [
            _i9.RouteConfig(
              MainScreenRoute.name,
              path: 'MainScreen',
              parent: RootRouter.name,
            ),
            _i9.RouteConfig(
              RunScreenRoute.name,
              path: 'RunScreen',
              parent: RootRouter.name,
            ),
            _i9.RouteConfig(
              RacesScreenRoute.name,
              path: 'RacesScreen',
              parent: RootRouter.name,
            ),
          ],
        ),
        _i9.RouteConfig(
          SettingsScreenRoute.name,
          path: 'SettingsScreen',
        ),
        _i9.RouteConfig(
          PostRunSurveyScreenRoute.name,
          path: 'PostRunSurveyScreen',
        ),
        _i9.RouteConfig(
          CreateRaceScreenRoute.name,
          path: 'CreateRaceScreen',
        ),
        _i9.RouteConfig(
          LoginScreenRoute.name,
          path: 'LoginScreen',
        ),
      ];
}

/// generated route for
/// [_i1.BottomNavigationPage]
class RootRouter extends _i9.PageRouteInfo<void> {
  const RootRouter({List<_i9.PageRouteInfo>? children})
      : super(
          RootRouter.name,
          path: '/',
          initialChildren: children,
        );

  static const String name = 'RootRouter';
}

/// generated route for
/// [_i2.SettingsScreen]
class SettingsScreenRoute extends _i9.PageRouteInfo<void> {
  const SettingsScreenRoute()
      : super(
          SettingsScreenRoute.name,
          path: 'SettingsScreen',
        );

  static const String name = 'SettingsScreenRoute';
}

/// generated route for
/// [_i3.PostRunSurveyScreen]
class PostRunSurveyScreenRoute extends _i9.PageRouteInfo<void> {
  const PostRunSurveyScreenRoute()
      : super(
          PostRunSurveyScreenRoute.name,
          path: 'PostRunSurveyScreen',
        );

  static const String name = 'PostRunSurveyScreenRoute';
}

/// generated route for
/// [_i4.CreateRaceScreen]
class CreateRaceScreenRoute
    extends _i9.PageRouteInfo<CreateRaceScreenRouteArgs> {
  CreateRaceScreenRoute({
    _i10.Key? key,
    _i11.RaceEvent? raceEvent,
  }) : super(
          CreateRaceScreenRoute.name,
          path: 'CreateRaceScreen',
          args: CreateRaceScreenRouteArgs(
            key: key,
            raceEvent: raceEvent,
          ),
        );

  static const String name = 'CreateRaceScreenRoute';
}

class CreateRaceScreenRouteArgs {
  const CreateRaceScreenRouteArgs({
    this.key,
    this.raceEvent,
  });

  final _i10.Key? key;

  final _i11.RaceEvent? raceEvent;

  @override
  String toString() {
    return 'CreateRaceScreenRouteArgs{key: $key, raceEvent: $raceEvent}';
  }
}

/// generated route for
/// [_i5.LoginScreen]
class LoginScreenRoute extends _i9.PageRouteInfo<void> {
  const LoginScreenRoute()
      : super(
          LoginScreenRoute.name,
          path: 'LoginScreen',
        );

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i6.MainScreen]
class MainScreenRoute extends _i9.PageRouteInfo<void> {
  const MainScreenRoute()
      : super(
          MainScreenRoute.name,
          path: 'MainScreen',
        );

  static const String name = 'MainScreenRoute';
}

/// generated route for
/// [_i7.RunScreen]
class RunScreenRoute extends _i9.PageRouteInfo<void> {
  const RunScreenRoute()
      : super(
          RunScreenRoute.name,
          path: 'RunScreen',
        );

  static const String name = 'RunScreenRoute';
}

/// generated route for
/// [_i8.RacesScreen]
class RacesScreenRoute extends _i9.PageRouteInfo<void> {
  const RacesScreenRoute()
      : super(
          RacesScreenRoute.name,
          path: 'RacesScreen',
        );

  static const String name = 'RacesScreenRoute';
}
