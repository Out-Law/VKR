import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

abstract class YaMapDistanceRepository {
  late Stream<Position> position;
}

@dev
@prod
@LazySingleton(as: YaMapDistanceRepository)
class YaMapDistanceRepositoryImpl implements YaMapDistanceRepository {
  @override
  late Stream<Position> position;

  YaMapDistanceRepositoryImpl() {
    LocationSettings locationOptions = const LocationSettings(
        accuracy: LocationAccuracy.high, distanceFilter: 5);
    position = Geolocator.getPositionStream(locationSettings: locationOptions)
        .timeout(const Duration(seconds: 1));
  }
}
