import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';

abstract class StreamPosition {
  late Stream<Position> position;
}

@dev
@prod
@LazySingleton(as:StreamPosition)
class StreamPositionImpl implements StreamPosition {

  @override
  late Stream<Position> position;

  StreamPositionImpl() {
    LocationSettings locationOptions = const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 5
    );
    position = Geolocator
        .getPositionStream(locationSettings: locationOptions)
        .timeout(const Duration(seconds: 1));
  }
}
