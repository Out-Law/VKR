import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

void showSnackbar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(text),
    ),
  );
}

Future<bool> hasInternet() async {
  bool result = await InternetConnectionChecker().hasConnection;
  if (result == true) {
    return true;
  } else {
    return false;
  }
}