import 'package:firebase_database/firebase_database.dart';
import 'package:run_app/utils/constants.dart';

Future<void> getUserName(String uid) async {
  var snapshot = await FirebaseDatabase.instance
      .ref()
      .child(uid)
      .child('name')
      .get();

  //print(snapshot.value);
}

Future<void> getUserPhoto(String uid) async {
  var snapshot = await FirebaseDatabase.instance
      .ref()
      .child(uid)
      .child('photo')
      .get();

  //print(snapshot.value);
}