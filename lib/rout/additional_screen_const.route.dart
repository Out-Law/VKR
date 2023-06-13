import 'package:auto_route/auto_route.dart';
import 'package:run_app/ui/screens/additional_screens/settings_screen.dart';

const settingsScreen = AutoRoute(
  path: 'SettingsScreen',
  page: SettingsScreen,
  name: 'SettingsScreenRoute',
);
