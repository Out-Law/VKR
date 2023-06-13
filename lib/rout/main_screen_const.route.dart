import 'package:auto_route/annotations.dart';
import 'package:run_app/rout/tab_button.router.dart';
import 'package:run_app/ui/screens/main/main_screen.dart';
import 'package:run_app/ui/screens/main/races_screen.dart';
import 'package:run_app/ui/screens/main/run_screen_map.dart';

const mainScreen = AutoRoute(
  path: 'MainScreen',
  page: MainScreen,
  name: 'MainScreenRoute',
);

const racesScreen = AutoRoute(
  path: 'RacesScreen',
  page: RacesScreen,
  name: 'RacesScreenRoute',
);

const runScreen = AutoRoute(
  path: 'RunScreen',
  page: RunScreen,
  name: 'RunScreenRoute',
);

const rootRoute = AutoRoute(
  page: BottomNavigationPage,
  initial: true,
  name: 'RootRouter',
  children: [
    mainScreen,
    runScreen,
    racesScreen,
  ],
);
