import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:run_app/modules/timer/entities/timer_event.dart';
import 'package:run_app/modules/timer/entities/timer_state.dart';
import 'package:run_app/utils/base_cubit.dart';

@injectable
class TimerCubit extends Cubit<TimerState> with BaseCubit<TimerState> {
  TimerCubit() : super(const TimerInitial(Duration.zero));

  StreamSubscription? _tickerSubscription;

  void handleEvent(TimerEvent event) {
    if (event is Start) {
      _mapStartToState(event);
    } else if (event is Stop) {
      _mapStopToState();
    } else if (event is Reset) {
      _mapResetToState();
    } else if (event is TickerUpdate) {
      _mapTickerUpdateToState(event);
    }
  }

  void _mapStartToState(Start start) {
    if (_tickerSubscription != null) {
      _tickerSubscription?.cancel();
    }

    _tickerSubscription = _ticker(Duration(hours: start.hours, minutes: start.minutes, seconds: start.seconds))
        .listen((duration) => handleEvent(TickerUpdate(duration)));

    cancelOnDispose(_tickerSubscription!);
  }

  void _mapStopToState() {
    _tickerSubscription?.cancel();
    _tickerSubscription = null;
  }

  void _mapResetToState() {
    _tickerSubscription?.cancel();
    _tickerSubscription = null;
    emit(const TimerInitial(Duration.zero));
  }

  void _mapTickerUpdateToState(TickerUpdate update) {
    emit(TimerRunInProgress(update.duration));
  }

  Stream<Duration> _ticker(Duration initialDuration) async* {
    Duration duration = initialDuration;
    while (true) {
      await Future.delayed(const Duration(seconds: 1));
      duration = duration + const Duration(seconds: 1);
      yield duration;
    }
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }
}
