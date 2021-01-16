import 'dart:convert';
import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_login/components/toast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_login/classes/user.dart';

class HttpService {
  final String URL = 'http://localhost:3000/api';

  Future<bool> userSignup(User user) async {
    final http.Response response = await http.post('$URL/auth/signup',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'name': user.getName(),
          'lastName': user.getLastName(),
          'email': user.getEmail(),
          'password': user.getPassword(),
          'date': user.getDate()
        }));

    //GESTIONE DEGLI ERRORI

    if (response.statusCode == HttpStatus.CREATED) {
      Map<String, dynamic> _res = jsonDecode(response.body);
      defaultToast(_res['message']);
      return Future<bool>.value(true);
    } else {
      Map<String, dynamic> _res = jsonDecode(response.body);
      errorToast(_res['message']);
    }
  }

  Future<String> userLogin(User user) async {
    final http.Response response = await http.post('$URL/auth/login',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          'email': user.getEmail(),
          'password': user.getPassword()
        }));

    if (response.statusCode == HttpStatus.OK) {
      Map<String, dynamic> _res = jsonDecode(response.body);
      String userId = _res['userFound']['_id'];
      return Future<String>.value(userId);
    } else {
      Map<String, dynamic> _res = jsonDecode(response.body);
      errorToast(_res['message']);
    }
  }

  Future<User> getUser(String _id) async {
    User user = new User();
    final http.Response response = await http.post('$URL/user/getUser',
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          '_id': _id,
        }));

    if (response.statusCode == HttpStatus.OK) {
      Map<String, dynamic> _res = jsonDecode(response.body);
      user.setName(_res['userFound']['name']);
      user.setLastName(_res['userFound']['lastName']);
      user.setDate(_res['userFound']['date']);
      return Future<User>.value(user);
    } else {
      Map<String, dynamic> _res = jsonDecode(response.body);
      errorToast(_res['message']);
    }
  }
}
