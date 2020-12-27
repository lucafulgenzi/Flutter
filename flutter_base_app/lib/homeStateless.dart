import 'package:flutter/material.dart';

class HomeStateless extends StatelessWidget {
  const HomeStateless({Key key, this.text}) : super(key: key);
  final String text;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(this.text),
      ),
      body: Center(
        child: Container(
          color: const Color(0xFFFF7F50),
          constraints: BoxConstraints(
              maxHeight: 300.0,
              maxWidth: 200.0,
              minWidth: 150.0,
              minHeight: 150.0),
        ),
      ),
    );
  }
}
