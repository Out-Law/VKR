part of '../data_run_part.dart';

class Time {
  final int hours;
  final int minutes;
  final int seconds;

  Time({required this.hours, required this.minutes, required this.seconds});
}

/*class Temp{
  final int minutes;
  final int seconds;

  Temp({required this.minutes, required this.seconds});
}*/

class DataRunState {
  final int calories;
  final double temp; ///min/km пока скорость
  final Time time;
  final String date;
  final double distance;
  final List<Point> routeHistoryLine;

  DataRunState(
      {required this.calories,
      required this.temp,
      required this.time,
      required this.date,
      required this.distance,
      required this.routeHistoryLine
      });
}
