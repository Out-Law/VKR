// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:run_app/modules/bottom_button_run/bottom_button_run_part.dart'
    as _i4;
import 'package:run_app/modules/color_selection_module/color_selection_part.dart'
    as _i5;
import 'package:run_app/modules/data_run/data_run_part.dart' as _i16;
import 'package:run_app/modules/geolocator/stream_position.dart' as _i11;
import 'package:run_app/modules/language_selection_module/presentation/bloc/language_selection_bloc.dart'
    as _i6;
import 'package:run_app/modules/reg_log_module/domain/rep/reg_log_firebase_rep.dart'
    as _i7;
import 'package:run_app/modules/reg_log_module/presentation/bloc/state_reg_log_cubit.dart'
    as _i10;
import 'package:run_app/modules/timer/presentation/bloc/timer_cubit.dart'
    as _i12;
import 'package:run_app/modules/yandex_map/domain/request_routes.dart' as _i8;
import 'package:run_app/modules/yandex_map/domain/yamap_distance_rep.dart'
    as _i14;
import 'package:run_app/modules/yandex_map/presentation/bloc/ganaration_track_cubit.dart'
    as _i9;
import 'package:run_app/modules/geolocator/presentation/bloc/location_cubit.dart'
    as _i17;
import 'package:run_app/modules/yandex_map/presentation/bloc/marker_discomfort_cubit.dart'
    as _i3;
import 'package:run_app/modules/yandex_map/presentation/bloc/users_in_run_cubit.dart'
    as _i13;
import 'package:run_app/modules/yandex_map/presentation/bloc/yandex_map_cubit.dart'
    as _i15;

const String _dev = 'dev';
const String _prod = 'prod';
// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  gh.factory<_i3.AdditionalPointYaMapCubit>(
      () => _i3.AdditionalPointYaMapCubit());
  gh.factory<_i4.BottomButtonRunCubit>(() => _i4.BottomButtonRunCubit());
  gh.factory<_i5.ColorSelectionCubit>(() => _i5.ColorSelectionCubit());
  gh.factory<_i6.LocaleCubit>(() => _i6.LocaleCubit());
  gh.lazySingleton<_i7.RegLogFirebaseRep>(
    () => _i7.RegLogFirebaseRepImpl(),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.lazySingleton<_i8.RequestRoutes>(
    () => _i8.RequestRoutesImpl(),
    registerFor: {
      _prod,
      _dev,
    },
  );
  gh.factory<_i9.RouteYaMapCubit>(
      () => _i9.RouteYaMapCubit(get<_i8.RequestRoutes>()));
  gh.factory<_i10.StateRegLogCubit>(
      () => _i10.StateRegLogCubit(get<_i7.RegLogFirebaseRep>()));
  gh.lazySingleton<_i11.StreamPosition>(
    () => _i11.StreamPositionImpl(),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i12.TimerCubit>(() => _i12.TimerCubit());
  gh.factory<_i13.UsersInCubitCubit>(() => _i13.UsersInCubitCubit());
  gh.lazySingleton<_i14.YaMapDistanceRepository>(
    () => _i14.YaMapDistanceRepositoryImpl(),
    registerFor: {
      _dev,
      _prod,
    },
  );
  gh.factory<_i15.YandexMapCubit>(() => _i15.YandexMapCubit());
  gh.factory<_i16.DataRunCubit>(
      () => _i16.DataRunCubit(get<_i11.StreamPosition>()));
  gh.factory<_i17.LocationCubit>(
      () => _i17.LocationCubit(get<_i11.StreamPosition>()));
  return get;
}
