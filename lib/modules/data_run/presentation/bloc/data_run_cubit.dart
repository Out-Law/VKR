part of '../../data_run_part.dart';

@injectable
class DataRunCubit extends Cubit<DataRunState> with BaseCubit<DataRunState> {
  final StreamPosition _streamPosition;
  bool _stateRun = false;

  DataRunCubit(this._streamPosition) : super(
      DataRunState(
          calories : 0,
          temp: 0.0,
          time: Time(hours: 0, minutes: 0, seconds: 0),
          distance: 0,
          routeHistoryLine: [],
          date: ''
      )){
    _streamPosition.position.skipWhile((element) => _stateRun).listen((event) {

      print("Test");

      List<Point> mapObjectsTemp = [];
      mapObjectsTemp.add(
          Point(latitude: event.latitude, longitude: event.longitude)
      );
      mapObjectsTemp.addAll(state.routeHistoryLine);

      emit(
        DataRunState(
            calories: state.distance.toInt() * 10,
            temp: event.speed.ceilToDouble(),
            time: Time(
                hours: event.timestamp?.hour ?? 0,
                minutes: event.timestamp?.minute ?? 0,
                seconds: event.timestamp?.second ?? 0
            ),
            distance: state.distance + 1,
            routeHistoryLine: mapObjectsTemp,
            date: ''
        )
      );

    });


    void startRun(){
      emit(
          DataRunState(
              calories: 0,
              temp: 0,
              time: Time(
                  hours: 0,
                  minutes: 0,
                  seconds: 0
              ),
              distance: 0,
              routeHistoryLine: [],
              date: ''
          )
      );

      _stateRun = true;
    }

    void finishRun(){
      _stateRun = false;

      emit(
          DataRunState(
              calories: 0,
              temp: 0,
              time: Time(
                  hours: 0,
                  minutes: 0,
                  seconds: 0
              ),
              distance: 0,
              routeHistoryLine: [],
              date: ''
          )
      );
    }
  }
}