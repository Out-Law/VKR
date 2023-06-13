import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';

mixin BaseCubit<T> on BlocBase<T> {
  final List<StreamSubscription> _streams = [];

  void cancelOnDispose(StreamSubscription s) {
    _streams.add(s);
  }

  void safe(FutureOr Function() call, {void Function(Object e)? onError}) {
    try {
      call();
    } on Object catch (e) {
      print('error: {$e}');
      onError?.call(e);
    }
  }

  @override
  Future<void> close() {
    for (final s in _streams) {
      s.cancel();
    }

    return super.close();
  }
}
