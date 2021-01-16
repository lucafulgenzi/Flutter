import 'package:flutter/material.dart';
import 'package:flutter_login/classes/user.dart';
import 'package:flutter_login/pages/homePage.dart';
import 'package:flutter_login/services/userService.dart';

import 'navPages/profilePage.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  final HttpService userService = HttpService();
  //DEFINE LOGGED USER
  static User user = new User();
  //DEFINE TAB SWITCH
  int _selectedIndex = 0;
  static List<Widget> _tabsList = <Widget>[
    Container(
      child: Home(),
    ),
    Container(),
    Container(
      child: Profile(),
    ),
  ];
  //SWITCH TAB
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map arguments = ModalRoute.of(context).settings.arguments;
    String id = arguments['id'];
    userService.getUser(id).then((value) => user.setUser(value));
    return Scaffold(
      appBar: null,
      body: Center(
        child: _tabsList.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Add',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.indigo,
        onTap: _onItemTapped,
      ),
    );
  }
}
