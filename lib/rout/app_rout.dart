import 'package:auto_route/annotations.dart';
import 'package:run_app/rout/additional_screen_const.route.dart';
import 'package:run_app/rout/main_screen_const.route.dart';
import 'package:run_app/rout/post_run_survey_screen_const.route.dart';
import 'package:run_app/rout/reg_log_screen_const.route.dart';
import 'package:run_app/rout/create_race_screen_const.route.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    rootRoute,

    settingsScreen,

    postRunSurveyScreen,

    createRaceScreen,

    loginScreen,
  ],
)
class $AppRouter {}
