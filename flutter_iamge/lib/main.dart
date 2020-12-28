import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyPage(),
    );
  }
}

class MyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const _PATH = "/images";
    const _PIC01 = "$_PATH/sunset.jpg";
    const _PIC02 = "$_PATH/dog1.jpg";
    const _PIC03 = "$_PATH/dog2.jpg";
    const _PIC04 = "$_PATH/fox.jpg";
    const _PIC05 = "$_PATH/spring.jpg";

    return Scaffold(
      appBar: AppBar(
        title: Text('Assets and Images'),
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          //SIMPLE IMAGE IMAGE.ASSET
          Container(
            constraints: BoxConstraints.expand(height: 300),
            alignment: Alignment.center,
            child: Image.asset(
              _PIC02,
              fit: BoxFit.cover,
            ),
          ),
          //SIMPLE IMAGE ASSETIMAGE
          Container(
            constraints: BoxConstraints.expand(height: 300),
            alignment: Alignment.center,
            child: Image(
              image: AssetImage(_PIC05),
              fit: BoxFit.cover,
            ),
          ),
          //SIMPLE IMAGE SIZE
          Container(
            color: Colors.blueGrey,
            child: Image.asset(
              _PIC01,
              width: 200,
              height: 200,
            ),
          ),
          //IMAGE BOX FIT FILL
          Container(
            color: Colors.blueGrey,
            child: Image.asset(
              _PIC01,
              fit: BoxFit.fill,
              height: 150,
              width: 150,
            ),
          ),
          //IMAGE BOX FIT FIT WIDTH
          Container(
            color: Colors.blueGrey,
            child: Image.asset(
              _PIC01,
              fit: BoxFit.fitWidth,
              height: 150,
              width: 150,
            ),
          ),
          //IMAGE BOX FIT FIT HEIGHT
          Container(
            color: Colors.blueGrey,
            child: Image.asset(
              _PIC01,
              fit: BoxFit.fitHeight,
              height: 150,
              width: 150,
            ),
          ),
          //IMAGE REPEAT X
          Container(
            constraints: BoxConstraints.expand(height: 50),
            margin: EdgeInsets.only(bottom: 15),
            child: Image.asset(
              _PIC03,
              repeat: ImageRepeat.repeatX,
              fit: BoxFit.contain,
            ),
          ),
          //IMAGE COLOR BLEND
          Container(
            child: Image.asset(
              _PIC04,
              color: Colors.purple,
              colorBlendMode: BlendMode.colorDodge,
            ),
          ),
          //IMAGE FILTER QUALITY NONE
          Container(
            color: Colors.blueGrey,
            child: Image.asset(
              _PIC05,
              filterQuality: FilterQuality.none,
            ),
          ),
          //IMAGE FILTER QUALITY HIGH
          Container(
            color: Colors.blueGrey,
            child: Image.asset(
              _PIC05,
              filterQuality: FilterQuality.high,
            ),
          ),
        ]),
      ),
    );
  }
}
