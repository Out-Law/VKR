  import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:run_app/modules/geolocator/app_lat_long.dart';
import 'package:run_app/modules/geolocator/location_service.dart';
import 'package:run_app/utils/base_cubit.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class ElementMarker{
  PlacemarkMapObject placemarkMapObject;

  ElementMarker copyWith({
    PlacemarkMapObject? placemarkMapObject,
  }) {
    return ElementMarker(
      placemarkMapObject: placemarkMapObject ?? this.placemarkMapObject,
    );
  }

  ElementMarker({required this.placemarkMapObject});
}

class ObjectGroups{
  TypeMarker type;
  List<ElementMarker> elements;

  ObjectGroups copyWith({
    List<ElementMarker>? elements,
  }) {
    return ObjectGroups(
      type: type,
      elements: elements ?? this.elements,
    );
  }

  ObjectGroups({required this.type, required this.elements});
}


enum TypeMarker {
  dogs('собаки'),
  noLight('сутствие'),
  danger('опасность');

  final String value;
  const TypeMarker(this.value);

  TypeMarker getTypeFromString(String type) {
    for (TypeMarker element in TypeMarker.values) {
      if (element.value == type) {
        return element;
      }
    }
    return TypeMarker.danger;
  }
}


@injectable
class AdditionalPointYaMapCubit extends Cubit<List<ObjectGroups>> with BaseCubit<List<ObjectGroups>> {
  AdditionalPointYaMapCubit() : super([]);


  Future<void> initial(BuildContext context) async {
    List<ObjectGroups> objects = [];
    ObjectGroups objectGroups;

    objectGroups = await generation("assets/imgs/petsMarker.png", 5, TypeMarker.dogs, context);
    objects.add(objectGroups);
    objectGroups = await generation("assets/imgs/lightMArker.png", 12, TypeMarker.noLight, context);
    objects.add(objectGroups);
    objectGroups = await generation("assets/imgs/AvariaMarker.png", 7, TypeMarker.danger, context);
    objects.add(objectGroups);

    emit(objects);
  }

  ///Отображение Точек
  Future<ObjectGroups> generation(String img, int count, TypeMarker id, BuildContext context) async {
    List<ElementMarker> elements = [];
    double latPoint;
    double lonPoint;
    double min = -0.0200;
    double randomMax = 0.0200;

    AppLatLong appLatLong = const AppLatLong(lat: 50.0, long: 50.0);

    appLatLong = await LocationService().getCurrentLocation();

    for(int i = 0; i < count; i++){

      latPoint = (Random().nextDouble() * (randomMax - min)) + min;
      lonPoint = (Random().nextDouble() * (randomMax - min)) + min;

      PlacemarkMapObject point = PlacemarkMapObject(
          opacity: 1,
          mapId: MapObjectId("${i.toString()}_${id.value}"),
          point: Point(
              latitude: appLatLong.lat + latPoint,
              longitude: appLatLong.long + lonPoint
          ),
          isVisible: false,
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(img),
          )),
      );

      ElementMarker element = ElementMarker(placemarkMapObject: point);
      elements.add(element);
    }

    ObjectGroups objects = ObjectGroups(type: id, elements: elements);

    return objects;
  }

  ///скрытие поинтов с карты и наоборот
  void visGroupObjects(TypeMarker id) {
    List<ObjectGroups> objectsTemp = state.map((e) {
      if (e.type == id) {
        return e.copyWith(
            elements: e.elements
                .map((element) => element.copyWith(
                placemarkMapObject: element.placemarkMapObject.copyWith(
                    isVisible: !element.placemarkMapObject.isVisible)))
                .toList());
      }
      return e;
    }).toList();

    emit(objectsTemp);
  }

  void addElements(){

  }

  void deleteElements(){

  }


 /* void clearGroupObjects(Type id){
    emit(state.where((item) => item.type != id).toList());
  }*/
}
