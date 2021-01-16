import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

defaultToast(String _message) {
  Fluttertoast.showToast(
      msg: _message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.grey[300],
      textColor: Colors.black87,
      fontSize: 17.0);
}

errorToast(String _message) {
  Fluttertoast.showToast(
      msg: _message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red[400],
      textColor: Colors.white,
      fontSize: 17.0);
}
