import 'package:injectable/injectable.dart';
import 'package:run_app/modules/geolocator/location_service.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';
import 'dart:math' as math;

abstract class RequestRoutes {
  Future<List<DrivingRoute>?> generateRandomRoute(double distanceInKm, double radius, List<Point> dangerousAreas);
}


@prod
@dev
@LazySingleton(as: RequestRoutes)
class RequestRoutesImpl implements RequestRoutes{

  @override
  Future<List<DrivingRoute>?> generateRandomRoute(double distanceInKm, double radius, List<Point> dangerousAreas) async {
    try {
      int attempts = 10;
      var endRandom = true;
      var location = await LocationService().getCurrentLocation();
      Point startPoint = Point(latitude: location.lat, longitude: location.long);
      DrivingSessionResult routePoints;
      while(endRandom){
        Point randomPoint = _generateRandomPointOnCircle(startPoint, distanceInKm);
        routePoints = await _getRoutes(startPoint, randomPoint);

        if(checkForHazardousSections(routePoints.routes?.first.geometry, dangerousAreas, radius)) {
          return routePoints.routes;
        }else{
          print("Не удачная попытка");
          attempts--;
          if(attempts <= 0){
            endRandom = false;
            print("Увы не удалось!");
          }
        }
      }
    } catch (e) {
      print("Error: route");
    }
    return [];
  }

  ///Метод для проверки дороги на опасные учаски
  bool checkForHazardousSections(List<Point>? route, List<Point> dangerousAreas, double radius) {
    for (int i = 0; i < dangerousAreas.length; i++) {
      for (int j = 0; j < route!.length; j++) {
        if (_distanceBetweenPoints(route[j], dangerousAreas[i]) <= radius) {
          return false;
        }
      }
    }
    return true;
  }


  double _distanceBetweenPoints(Point point1, Point point2) {
    const double kmPerDegree = 111.195;

    double lat1 = point1.latitude;
    double lon1 = point1.longitude;
    double lat2 = point2.latitude;
    double lon2 = point2.longitude;

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    return kmPerDegree * math.sqrt(dLat * dLat + dLon * dLon);
  }


  /*double _distanceBetweenPoints(Point point1, Point point2) {
    const double earthRadiusInKm = 6371.0;

    double lat1 = point1.latitude * (math.pi / 180.0);
    double lon1 = point1.longitude * (math.pi / 180.0);
    double lat2 = point2.latitude * (math.pi / 180.0);
    double lon2 = point2.longitude * (math.pi / 180.0);

    double dLat = lat2 - lat1;
    double dLon = lon2 - lon1;

    double a = math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(lat1) * math.cos(lat2) * math.sin(dLon / 2) * math.sin(dLon / 2);
    double c = 2 * math.atan2(math.sqrt(a), math.sqrt(1 - a));

    return earthRadiusInKm * c;
  }*/

  Point _generateRandomPointOnCircle(Point center, double radiusInKm) {
    const double kmPerDegree = 111.12;
    double radiusInDegrees = radiusInKm / kmPerDegree;

    // Генерация случайного угла
    double randomAngle = math.Random().nextDouble() * 2 * math.pi;

    // Вычисление новых координат
    double newLat = center.latitude + radiusInDegrees * math.cos(randomAngle);
    double newLng = center.longitude + radiusInDegrees * math.sin(randomAngle);

    return Point(latitude: newLat, longitude: newLng);
  }


 /* Point _generateRandomPointOnCircle(Point center, double radiusInKm) {
    const double earthRadiusInKm = 6371.0;

    // Конвертация координат в радианы
    double centerLat = center.latitude * (math.pi / 180.0);
    double centerLng = center.longitude * (math.pi / 180.0);

    // Генерация случайного угла
    double randomAngle = math.Random().nextDouble() * 2 * math.pi;

    // Вычисление новых координат
    double newLat = math.asin(math.sin(centerLat) * math.cos(radiusInKm / earthRadiusInKm)
        + math.cos(centerLat) * math.sin(radiusInKm / earthRadiusInKm) * math.cos(randomAngle));
    double newLng = centerLng + math.atan2(math.sin(randomAngle) * math.sin(radiusInKm / earthRadiusInKm)
        * math.cos(centerLat), math.cos(radiusInKm / earthRadiusInKm) - math.sin(centerLat) *

        math.sin(newLat));

    // Конвертация радианов обратно в градусы
        newLat = newLat * (180.0 / math.pi);
        newLng = newLng * (180.0 / math.pi);

    return Point(latitude: newLat, longitude: newLng);
  }*/

  Future<DrivingSessionResult> _getRoutes(Point startPoint, Point randomPoint) async {

    var resultWithSession = YandexDriving.requestRoutes(
        points: [
          RequestPoint(point: startPoint, requestPointType: RequestPointType.wayPoint),
          RequestPoint(point: randomPoint, requestPointType: RequestPointType.wayPoint),
        ],
        drivingOptions: const DrivingOptions(
            initialAzimuth: 0,
            routesCount: 1,
        )
    );

    return resultWithSession.result;
  }
}