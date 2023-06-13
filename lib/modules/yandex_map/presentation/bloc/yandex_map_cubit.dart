import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:run_app/modules/geolocator/app_lat_long.dart';
import 'package:run_app/utils/base_cubit.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';


class StateYandexMap {
  YandexMapController? controller;
  final bool nightMode;

  StateYandexMap( {this.controller, required this.nightMode});
}


@injectable
class YandexMapCubit extends Cubit<StateYandexMap> with BaseCubit<StateYandexMap> {

  YandexMapCubit() : super(
      StateYandexMap(nightMode: true,)
  );

  Future<void> userLocation(double width, double height, bool visible) async {
    await state.controller?.toggleUserLayer(
        visible: visible,
        autoZoomEnabled: false,
        anchor: UserLocationAnchor(
            course: Offset(0.5 * width, 0.5 * height),
            normal: Offset(0.5 * width, 0.5 * height)
        )
    );
  }

  /// Метод для приближения камер к текущей позиции
  void moveToCurrentLocation(AppLatLong appLatLong) {
    state.controller?.moveCamera(
      animation: const MapAnimation(type: MapAnimationType.linear, duration: 1),
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: Point(
            latitude: appLatLong.lat,
            longitude: appLatLong.long,
          ),
          zoom: 15,
        ),
      ),
    );


    /* final animation = MapAnimation(type: MapAnimationType.smooth, duration: 2.0);
    final newBounds = BoundingBox(
      northEast: Point(latitude: 65.0, longitude: 40.0),
      southWest: Point(latitude: 60.0, longitude: 30.0),
    );
    await state.controller?.moveCamera(
        CameraUpdate.newTiltAzimuthBounds(newBounds, azimuth: 1, tilt: 1),
        animation: animation
    );*/
  }

  /// Метод для убирание таргета с поинта юзвера
  /*void stopTrackingUserPosition() {
    state.controller?
  }*/

  void setController(YandexMapController yandexMapController){
    emit(
        StateYandexMap(
            nightMode: state.nightMode,
            controller: yandexMapController
        ));
  }
}