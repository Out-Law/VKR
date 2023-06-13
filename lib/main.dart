import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:run_app/modules/app_module.dart';
import 'package:run_app/modules/bottom_button_run/bottom_button_run_part.dart';
import 'package:run_app/modules/color_selection_module/color_selection_part.dart';
import 'package:run_app/modules/data_run/data_run_part.dart';
import 'package:run_app/modules/language_selection_module/presentation/bloc/language_selection_bloc.dart';
import 'package:run_app/modules/timer/presentation/bloc/timer_cubit.dart';
import 'package:run_app/modules/yandex_map/presentation/bloc/ganaration_track_cubit.dart';
import 'package:run_app/modules/geolocator/presentation/bloc/location_cubit.dart';
import 'package:run_app/modules/yandex_map/presentation/bloc/marker_discomfort_cubit.dart';
import 'package:run_app/modules/yandex_map/presentation/bloc/users_in_run_cubit.dart';
import 'package:run_app/modules/yandex_map/presentation/bloc/yandex_map_cubit.dart';
import 'package:run_app/modules/reg_log_module/presentation/bloc/state_reg_log_cubit.dart';
import 'package:run_app/resources/themes.dart';
import 'package:run_app/rout/app_rout.gr.dart';
import 'package:run_app/firebase_options.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  //Включение локльного хранилищя
  FirebaseDatabase.instance.setPersistenceEnabled(true);

  final appRouter = AppRouter();
  configureDependencies(Environment.prod);
  runApp( MyApp(appRouter: appRouter));
}

class MyApp extends StatelessWidget {
  final AppRouter appRouter;

  const MyApp({Key? key, required this.appRouter}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode (SystemUiMode.manual, overlays: []);
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.I<ColorSelectionCubit>()),
        BlocProvider(create: (_) => GetIt.I<YandexMapCubit>()),
        BlocProvider(create: (_) => GetIt.I<AdditionalPointYaMapCubit>()),
        BlocProvider(create: (_) => GetIt.I<DataRunCubit>()),
        BlocProvider(create: (_) => GetIt.I<LocationCubit>()),
        BlocProvider(create: (_) => GetIt.I<UsersInCubitCubit>()),
        BlocProvider(create: (_) => GetIt.I<BottomButtonRunCubit>()),
        BlocProvider(create: (_) => GetIt.I<StateRegLogCubit>()),
        BlocProvider(create: (_) => GetIt.I<TimerCubit>()),
        BlocProvider(create: (_) => GetIt.I<RouteYaMapCubit>()),
        BlocProvider(create: (_) => GetIt.I<LocaleCubit>()),
      ],
      child: startWidget(context)
    );
  }

  Widget startWidget(BuildContext context) {
    final isPlatformDark = WidgetsBinding.instance.window.platformBrightness == Brightness.dark;
    final initTheme = isPlatformDark ? blueDarkTheme : blueLightTheme;
    return BlocBuilder<ColorSelectionCubit, ColorThemeState>(
        builder: (ctx, value) {
          return MaterialApp.router(
            localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale("en", 'EN'),
              Locale("ru", 'RU'),
            ],
            theme: value.themeData,
            debugShowCheckedModeBanner: false,
            routerDelegate: appRouter.delegate(),
            routeInformationParser: appRouter.defaultRouteParser(),
          );
    });
  }
}
