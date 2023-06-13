import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:run_app/modules/geolocator/presentation/bloc/location_cubit.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'dart:math';

class Users {
  final int id;
  final List<User> users;

  Users({required this.id, required this.users});

  factory Users.fromJson(Map<String, dynamic> json) {
    final id = json['id'] as int;
    final users = (json['users'] as List).map((u) => User.fromJson(u)).toList();
    return Users(id: id, users: users);
  }

  Map<String, dynamic> toJson() => {'id': id, 'users': users.map((u) => u.toJson()).toList()};
}


@injectable
class UsersInCubitCubit extends Cubit<Users> {

  UsersInCubitCubit() : super(
      Users(
          id: 0,
          users: []
      )){

    final wsUrl = Uri.parse('ws://192.168.2.208:5000');
    var channel = WebSocketChannel.connect(wsUrl);

    print("CUBIT!!!");
    
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
        Users(
            id: Random().nextInt(100),
            users: []
        )
    );


   /* socket.on('users_list', (data) {
      print("ANSWER $data");
    });*/

    channel.stream.timeout(const Duration(seconds: 15)).listen((message) {
      print("ANSWER $message");
      var temp = <User>[];
      final data = json.decode(message);
      temp.add(User(runnerId: data['runner_id'], position: data['position']));
      temp.addAll(state.users);
      
      emit(
          Users(
              id: state.id,
              users: temp
          )
      );

      //print("ANSWER $message");
    });
  }

}
