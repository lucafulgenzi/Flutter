import 'package:flutter/material.dart';
import 'package:flutter_login/classes/user.dart';
import 'package:flutter_login/pages/navRoutes.dart';

class Profile extends StatelessWidget {
  final name = Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Text(''),
  );
  final lastName = Padding(
    padding: EdgeInsets.only(bottom: 10),
    child: Text('Cognome utente'),
  );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: <Widget>[
            name,
            lastName,
          ],
        ),
      ),
    );
  }
}
