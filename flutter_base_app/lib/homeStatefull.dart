import 'package:flutter/material.dart';

class HomeStatefull extends StatefulWidget {
  HomeStatefull({Key key}) : super(key: key);
  @override
  _HomeStatefullState createState() => _HomeStatefullState();
}

class _HomeStatefullState extends State<HomeStatefull> {
  int _counter = 0;
  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Counter'),
      ),
      body: Center(
          child: Text(
        '$_counter',
        style: TextStyle(fontSize: 30),
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        child: Icon(Icons.add),
      ),
    );
  }
}
