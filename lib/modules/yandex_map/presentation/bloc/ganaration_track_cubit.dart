import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:run_app/modules/yandex_map/domain/request_routes.dart';
import 'package:run_app/utils/base_cubit.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';


class PolylineObjects{
  String id;
  String? range;
  String? time;
  PolylineMapObject polylineMapObject;

  PolylineObjects copyWith({
    PolylineMapObject? polylineMapObject,
  }) {
    return PolylineObjects(
      id: id,
      range: range,
      time: time,
      polylineMapObject: polylineMapObject ?? this.polylineMapObject,
    );
  }

  PolylineObjects({
    required this.id,
    required this.range,
    required this.time,
    required this.polylineMapObject,
  });
}

class StatePolyline{
  int? selected;
  List<PolylineObjects> polylineObjects;

  StatePolyline({
    required this.selected,
    required this.polylineObjects
  });
}


@injectable
class RouteYaMapCubit extends Cubit<StatePolyline> with BaseCubit<StatePolyline> {
  final RequestRoutes _requestRoutes;
  List<DrivingRoute>? result;

  RouteYaMapCubit(this._requestRoutes) : super(
      StatePolyline(
          polylineObjects: [],
          selected: null
      )
  );

  Future<void> generateRandomRoute(double distanceInKm,   double radius,   List<Point> dangerousAreas) async {
    result =  await _requestRoutes.generateRandomRoute(distanceInKm, radius, dangerousAreas);
    handleResult();
  }

  Future<void> handleResult() async {

    if (result?.isEmpty == true) {
      print('Error: result');
      return;
    }

    List<PolylineObjects> mapObjectsTemp = [];

    print("CLick ${result?.length}");
    result!.asMap().forEach((i, route) {
      mapObjectsTemp.add(
          PolylineObjects(
              id: i.toString(),
              range: route.metadata.weight.distance.text,
              time: route.metadata.weight.time.text,
              polylineMapObject: PolylineMapObject(
                mapId: MapObjectId('route_${i}_polyline'),
                polyline: Polyline(points: route.geometry),
                strokeColor: Colors.blue,
                strokeWidth: 3,
              )
          ));
    });

    emit(
        StatePolyline(
            polylineObjects: mapObjectsTemp,
            selected: state.selected
        ));
  }

  ///конвертация
  List<PolylineMapObject> getRoute(){
    List<PolylineMapObject> mapObjectsTemp = [];
    state.polylineObjects.asMap().forEach((i, route) {
      mapObjectsTemp.add(route.polylineMapObject);
    });
    return mapObjectsTemp;
  }

  ///Удаление лишних дорог
  void removeRoute(int? id){
    emit(
        StatePolyline(
            polylineObjects: state.polylineObjects.where((item) => item.id == id.toString()).toList(),
            selected: state.selected
        )
    );
  }

  void removeAll(){
    emit(
        StatePolyline(
            polylineObjects: [],
            selected: null
        ));
  }
}