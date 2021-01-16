import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/classes/user.dart';
import 'package:flutter_login/components/toast.dart';
import 'package:flutter_login/pages/homePage.dart';
import 'package:flutter_login/pages/signupPage.dart';
import 'package:flutter_login/services/userService.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  //FORM VALIDATION KEY
  final _formKey = GlobalKey<FormState>();

  User user = new User();
  final HttpService userService = HttpService();

  @override
  Widget build(BuildContext context) {
    //LOGO WIDGET
    final logo = Padding(
      padding: EdgeInsets.all(20),
      child: Hero(
          tag: 'hero',
          child: SizedBox(
            height: 300,
            child: Image.asset('assets/ub-logo.png'),
          )),
    );

    //EMAIL FORM WIDGET
    final inputEmail = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        autocorrect: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            hintText: 'Email',
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter email';
          }
          if (!isValidEmail(value)) {
            return 'Please enter email';
          }
          return null;
        },
        onSaved: (value) => {user.setEmail(value)},
      ),
    );

    //PASSWORD FORM WIDGET
    final inputPassword = Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Password',
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter password';
          }
          return null;
        },
        onSaved: (value) => {user.setPassword(value)},
      ),
    );

    //LOGIN BUTTON WIDGET
    final buttonLogin = Padding(
      padding: EdgeInsets.only(bottom: 5, left: 50, right: 50),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
          child: Text('Login',
              style: TextStyle(color: Colors.white, fontSize: 20)),
          color: Colors.black87,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          onPressed: () => {
            if (_formKey.currentState.validate()) {_submitForm()}
          },
        ),
      ),
    );

    //SIGNUP BUTTON WIDGET
    final buttonSignUp = FlatButton(
        child: Text(
          'Registrati',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SignUp()));
        });

    //FORGOT PASSWORD BUTTON WIDGET
    final buttonForgotPassword = FlatButton(
        child: Text(
          'Password dimenticata?',
          style: TextStyle(color: Colors.grey, fontSize: 16),
        ),
        onPressed: null);

    return SafeArea(
        child: Scaffold(
            body: Center(
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(horizontal: 30),
          children: <Widget>[
            logo,
            inputEmail,
            inputPassword,
            buttonLogin,
            buttonSignUp,
            buttonForgotPassword
          ],
        ),
      ),
    )));
  }

  bool isValidEmail(String input) {
    final RegExp regex =
        new RegExp(r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$");
    return regex.hasMatch(input);
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate()) {
      errorToast("Email/Password invalid");
    } else {
      form.save();
      userService.userLogin(user).then((value) => {
            if (value != null)
              {
                Navigator.pushNamed(context, '/nav', arguments: {'id': value})
              }
          });
    }
  }
}
