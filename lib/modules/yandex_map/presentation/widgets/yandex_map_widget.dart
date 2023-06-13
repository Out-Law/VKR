import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:run_app/modules/data_run/data_run_part.dart';
import 'package:run_app/modules/geolocator/app_lat_long.dart';
import 'package:run_app/modules/geolocator/location_service.dart';
import 'package:run_app/modules/yandex_map/presentation/bloc/ganaration_track_cubit.dart';
import 'package:run_app/modules/geolocator/presentation/bloc/location_cubit.dart';
import 'package:run_app/modules/yandex_map/presentation/bloc/marker_discomfort_cubit.dart';
import 'package:run_app/modules/yandex_map/presentation/bloc/users_in_run_cubit.dart';
import 'package:run_app/modules/yandex_map/presentation/bloc/yandex_map_cubit.dart';
import 'package:run_app/modules/yandex_map/presentation/widgets/animated_button.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class YandexMapWidget extends StatefulWidget {
  final Function() onOpenInformationRun;
  final bool? visRunData;
  const YandexMapWidget({
    Key? key,
    required this.onOpenInformationRun,
    this.visRunData = true
  }) : super(key: key);

  @override
  State<YandexMapWidget> createState() => _YandexMapWidgetState();
}

class _YandexMapWidgetState extends State<YandexMapWidget> {

  @override
  void initState() {
    super.initState();
    _initPermission(context).ignore();

    Future.delayed(const Duration(seconds: 4), () {
      context.read<AdditionalPointYaMapCubit>().initial(context);
    });
  }

  GlobalKey mapKey = GlobalKey();
  final _runnerMarkers = <int, PlacemarkMapObject>{};
  final _routeHistoryLine = <PolylineMapObject>[PolylineMapObject(
  mapId: const MapObjectId('route_${0}_polyline'),
  polyline: const Polyline(points: []),
  strokeColor: Colors.blue,
  strokeWidth: 3,
  )];


  // Добавление маркеров бегунов на карту
  void addRunnerMarkers(Users users) {
    _runnerMarkers.clear();

    for (final user in users.users) {
      final runnerMarker = PlacemarkMapObject(
          mapId: MapObjectId(user.runnerId.toString()),
          point: Point(
              latitude: user.position.latitude,
              longitude: user.position.longitude),
          isVisible: false,
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
            image: BitmapDescriptor.fromAssetImage(
                "assets/icons/settings.svg"
            ),
          )));

      _runnerMarkers[users.id] = runnerMarker;
    }
  }

  void addRoute(List<Point> mapObjectsTemp){

    _routeHistoryLine[0] = PolylineMapObject(
      mapId: const MapObjectId('route_${0}_polyline'),
      polyline: Polyline(points: mapObjectsTemp),
      strokeColor: Colors.blue,
      strokeWidth: 3,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdditionalPointYaMapCubit, List<ObjectGroups>>(
        builder: (ctx, valueAdditinal) {
    return Stack(
      children: [
        BlocBuilder<YandexMapCubit, StateYandexMap>(
            builder: (ctx, valueYandex) {
              return BlocBuilder<LocationCubit, User>(
                  builder: (ctx, valueLocationUser) {
                    return BlocBuilder<UsersInCubitCubit, Users>(
                        builder: (ctx, valueLocationUsers) {
                          return BlocBuilder<DataRunCubit, DataRunState>(
                              builder: (ctx, valueData) {
                                  return BlocBuilder<RouteYaMapCubit, StatePolyline>(
                                  builder: (ctx, valueRoute) {

                                addRunnerMarkers(valueLocationUsers);
                                addRoute(valueData.routeHistoryLine);

                                return YandexMap(
                                  key: mapKey,
                                  mode2DEnabled: true,
                                  poiLimit: 0,
                                  modelsEnabled: true,
                                  nightModeEnabled: false,
                                  onMapTap: (value){
                                    
                                  },
                                  onMapCreated: (
                                      YandexMapController yandexMapController) async {
                                    context.read<YandexMapCubit>().setController(yandexMapController);
                                  },
                                  onUserLocationAdded: (
                                      UserLocationView view) async {
                                    return view.copyWith(
                                        pin: view.pin.copyWith(
                                            opacity: 1,
                                            icon: PlacemarkIcon.single(
                                                PlacemarkIconStyle(
                                                    isFlat: true,
                                                    image: BitmapDescriptor
                                                        .fromAssetImage(
                                                        "assets/imgs/photo.png")))),
                                        arrow: view.arrow.copyWith(
                                            opacity: 1,
                                            icon: PlacemarkIcon.single(
                                                PlacemarkIconStyle(
                                                    isFlat: true,
                                                    image: BitmapDescriptor
                                                        .fromAssetImage(
                                                        "assets/imgs/photo.png")))),
                                        accuracyCircle: view.accuracyCircle
                                            .copyWith(
                                            fillColor: Colors.transparent,
                                            isVisible: false,
                                            strokeColor: Colors.transparent));
                                  },
                                  mapObjects: convertForHistoryRoute(_routeHistoryLine)
                                      + convertForAdditionalMap(valueAdditinal)
                                      + convertForRoute(valueRoute.polylineObjects),
                                );
                              });
                                  });
                  });
                  });
            }),

        ///Виджет с данными по бегу
        Visibility(
          visible: widget.visRunData!,
          child: Positioned(
              left: 24,
              right: 24,
              top: 8,
              child: Column(
                children: [
                  DataRunAboveMap(
                    onOpenInformationRun: () {
                      widget.onOpenInformationRun();
                    },
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(top: 16),
                    child: AnimatedButton(),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    padding: const EdgeInsets.only(top: 16),
                    child: FloatingActionButton(
                      onPressed: () {
                        context.read<RouteYaMapCubit>().generateRandomRoute(2, 0.1, objectGroupsListToPoints(valueAdditinal));
                      },
                    )
                  )
                ],
              )),
        ),

      ],
    );
        });
  }

  /// Проверка разрешений на доступ к геопозиции пользователя
  Future<void> _initPermission(BuildContext context) async {
    if (!await LocationService().checkPermission()) {
      await LocationService().requestPermission();
    }
    await _fetchCurrentLocation(context, true);
  }

  Future<void> _fetchCurrentLocation(BuildContext context, bool value) async {
    AppLatLong location;
    const defLocation = MoscowLocation();
    try {
      location = await LocationService().getCurrentLocation();
    } catch (_) {
      location = defLocation;
    }
    location = await LocationService().getCurrentLocation();
    context.read<YandexMapCubit>().moveToCurrentLocation(location);

    final mediaQuery = MediaQuery.of(context);
    final height = mapKey.currentContext!.size!.height * mediaQuery.devicePixelRatio;
    final width = mapKey.currentContext!.size!.width * mediaQuery.devicePixelRatio;
    context.read<YandexMapCubit>().userLocation(width, height, value);
  }


  ///конвертировать из List<Objects> в List<MapObject<dynamic>>
 /* List<MapObject<dynamic>> convertForMap(List<Objects> objects){
    List<MapObject<dynamic>> temp = [];
    for (var element in objects) {
      temp.add(element.placemarkMapObject);
    }
    return temp;
  }*/

  ///конвертировать из List<PolylineObjects> в List<MapObject<dynamic>>
  List<MapObject<dynamic>> convertForRoute(List<PolylineObjects> objects){
    List<MapObject<dynamic>> temp = [];
    for (var element in objects) {
      temp.add(element.polylineMapObject);
    }
    return temp;
  }

  ///конвертировать из List<PolylineObjects> в List<MapObject<dynamic>>
  List<MapObject<dynamic>> convertForHistoryRoute(List<PolylineMapObject> objects){
    List<MapObject<dynamic>> temp = [];
    for (var element in objects) {
      temp.add(element);
    }
    return temp;
  }

  ///конвертировать из List<ObjectGroups> в List<MapObject<dynamic>>
  List<MapObject<dynamic>> convertForAdditionalMap(List<ObjectGroups> objects){
    List<MapObject<dynamic>> temp = [];

    for(int i = 0; i < objects.length; i++){
      for(int j = 0; j < objects[i].elements.length; j++){
        temp.add(objects[i].elements[j].placemarkMapObject);
      }
    }
    return temp;
  }


  List<Point> objectGroupsListToPoints(List<ObjectGroups> objectGroupsList) {
    List<Point> points = [];

    for (ObjectGroups objectGroups in objectGroupsList) {
      for (ElementMarker element in objectGroups.elements) {
        points.add(element.placemarkMapObject.point);
      }
    }

    return points;
  }

}
