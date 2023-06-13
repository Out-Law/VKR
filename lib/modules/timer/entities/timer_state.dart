import 'package:meta/meta.dart';

@immutable
abstract class TimerState {
  final Duration duration;

  const TimerState(this.duration);
}

class TimerInitial extends TimerState {
  const TimerInitial(Duration duration) : super(duration);
}

class TimerRunInProgress extends TimerState {
  const TimerRunInProgress(Duration duration) : super(duration);
}
