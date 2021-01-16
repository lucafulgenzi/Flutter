import 'package:flutter/material.dart';
import 'package:convert/convert.dart';
import 'package:flutter_login/classes/user.dart';
import 'package:flutter_login/services/userService.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_login/components/toast.dart';

class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  //FORM VALIDATION KEY
  final _formKey = GlobalKey<FormState>();
  final dateController = TextEditingController();

  final HttpService userService = HttpService();

  bool _checkBox = false;
  User user = new User();

  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //NAME FORM WIDGET
    final inputName = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Name',
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter your name';
          }
          return null;
        },
        onSaved: (value) => {user.setName(value.trim())},
      ),
    );

    //LAST NAME FORM WIDGET
    final inputLastName = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
            hintText: 'Last Name',
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter last name';
          }
          return null;
        },
        onSaved: (value) => {user.setLastName(value.trim())},
      ),
    );

    //EMAIL FORM WIDGET
    final inputEmail = Padding(
      padding: EdgeInsets.only(bottom: 10),
      child: TextFormField(
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
        onSaved: (value) => {user.setEmail(value.toLowerCase().trim())},
      ),
    );

    //DATA FORM WIDGET
    final inputData = Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: TextFormField(
          readOnly: true,
          controller: dateController,
          decoration: InputDecoration(
              hintText: 'Date',
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 25, vertical: 20),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0))),
          onTap: () async {
            var date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now());
            dateController.text = date.toString().substring(0, 10);
          },
          validator: (value) {
            if (value.isEmpty) {
              return 'Please enter date';
            }
            return null;
          },
          onSaved: (value) => {user.setDate(value)},
        ));

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
        onChanged: (value) => {user.setPassword(value)},
      ),
    );

    //PASSWORD FORM WIDGET
    final inputConfirmPassword = Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
            hintText: 'Confirm Password',
            contentPadding: EdgeInsets.symmetric(horizontal: 25, vertical: 20),
            border:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20.0))),
        validator: (value) {
          if (value.isEmpty) {
            return 'Please enter password';
          }
          if (user.getPassword() != value) {
            return 'Password does not match';
          }

          return null;
        },
        onSaved: (value) => {},
      ),
    );

    //FORM CHECKBOX WIDGET
    final inputCheck = Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('I Agree to Privacy Policy'),
            Checkbox(
                value: _checkBox,
                onChanged: (onChanged) {
                  setState(() {
                    _checkBox = !_checkBox;
                  });

                  //ABILITA PULSANTE
                })
          ],
        ));

    //SIGNUP BUTTON WIDGET
    final buttonSignUp = Padding(
      padding: EdgeInsets.only(bottom: 5, left: 50, right: 50),
      child: ButtonTheme(
        height: 56,
        child: RaisedButton(
          child: Text('REGISTRATI',
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

    return Scaffold(
        appBar: AppBar(),
        body: Center(
          child: Form(
            key: _formKey,
            child: ListView(
              shrinkWrap: true,
              padding: EdgeInsets.symmetric(horizontal: 30),
              children: <Widget>[
                inputName,
                inputLastName,
                inputEmail,
                inputData,
                inputPassword,
                inputConfirmPassword,
                inputCheck,
                buttonSignUp,
              ],
            ),
          ),
        ));
  }

  bool isValidEmail(String input) {
    final RegExp regex =
        new RegExp(r"^[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,4}$");
    return regex.hasMatch(input);
  }

  void _submitForm() {
    final FormState form = _formKey.currentState;

    if (!form.validate() || !_checkBox) {
      errorToast("Check the privacy");
    } else {
      form.save();
      userService.userSignup(user).then((value) => {
            if (value == true) {Navigator.pop(context)}
          });
    }
  }
}
