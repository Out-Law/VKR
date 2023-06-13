import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:injectable/injectable.dart';
import 'package:run_app/modules/geolocator/stream_position.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:math';

class User {
  final int runnerId;
  final Position position;

  User({required this.runnerId, required this.position});

  factory User.fromJson(Map<String, dynamic> json) {
    final runnerId = json['runnerId'] as int;
    final position = Position.fromMap(json['position']);
    return User(runnerId: runnerId, position: position);
  }

  Map<String, dynamic> toJson() => {'runnerId': runnerId, 'position': position.toJson()};
}

class LocationState extends Equatable {
  final Position position;

  const LocationState(this.position);

  @override
  List<Object> get props => [position];
}

@injectable
class LocationCubit extends Cubit<User> {
  final StreamPosition _streamPosition;

  LocationCubit(this._streamPosition) : super(
      User(
    runnerId: 0,
    position:  Position(
        longitude: 0,
        latitude: 0,
        timestamp: DateTime(2022),
        accuracy: 0,
        altitude: 0,
        heading: 0,
        speed: 0,
        speedAccuracy: 0
    )
  )){
    final wsUrl = Uri.parse('ws://192.168.2.208:5000/ws');
    var channel = WebSocketChannel.connect(wsUrl);


   /* IO.Socket socket = IO.io('ws://192.168.2.208:5000', <String, dynamic>{
      'transports': ['websocket'],
    });

    socket.on('connect', (_) {
      print('Connected');
    });

    socket.onError((data) {
      print("Error : $data");
      return data;
    });*/

    emit(
        User(
            runnerId: Random().nextInt(100),
            position: state.position
        )
    );

    _streamPosition.position.listen((event) {
      emit(
          User(
          runnerId: state.runnerId,
          position: event
      ));
      channel.sink.add(state.toJson().toString());
      //socket.emit("position_update" ,state.toJson());
      print("Work!!!!! ${state.toJson()}");
    });
  }

}
