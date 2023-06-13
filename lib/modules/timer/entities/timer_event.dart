abstract class TimerEvent {}

class Start extends TimerEvent {
  final int hours;
  final int minutes;
  final int seconds;

  Start({required this.hours, required this.minutes, required this.seconds});
}

class Tick extends TimerEvent {
  final Duration duration;

  Tick({required this.duration});
}

class Reset extends TimerEvent {}

class Stop extends TimerEvent {}

class TickerUpdate extends TimerEvent {
  final Duration duration;

  TickerUpdate(this.duration);
}
