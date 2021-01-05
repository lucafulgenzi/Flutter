import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  static final String title = 'Flutter Note';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.lightGreen,
        ),
        home: MyHome());
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  List<String> noteList = new List();
  final myController = TextEditingController();
  final dialogController = TextEditingController();

  void dispose() {
    myController.dispose();
    dialogController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(MyApp.title)),
      body: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Container(
                    width: 300,
                    child: TextField(
                      controller: myController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.green[200]),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                          ),
                          hintText: 'Enter note...'),
                    ),
                  ),
                  Container(
                    child: Ink(
                      decoration: const ShapeDecoration(
                        color: Colors.green,
                        shape: CircleBorder(),
                      ),
                      child: IconButton(
                          icon: Icon(Icons.add),
                          color: Colors.white,
                          onPressed: () {
                            if (myController.text.isNotEmpty) {
                              setState(() {
                                noteList.add(myController.text);
                                myController.clear();
                              });
                            }
                          }),
                    ),
                  ),
                ],
              )),
          Expanded(
              child: ListView.builder(
                  itemCount: noteList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                          title: new Text(noteList[index]),
                          leading: GestureDetector(
                            child: Icon(Icons.edit),
                            onTap: () {
                              print('click modify');
                              return showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text('Modify note'),
                                      content: TextField(
                                        controller: dialogController,
                                        decoration: InputDecoration(
                                            hintText: 'Enter note...'),
                                      ),
                                      actions: <Widget>[
                                        FlatButton(
                                            onPressed: () {
                                              if (dialogController
                                                  .text.isNotEmpty) {
                                                setState(() {
                                                  noteList.replaceRange(
                                                      index,
                                                      index + 1,
                                                      [dialogController.text]);
                                                  dialogController.clear();
                                                  Navigator.pop(context);
                                                });
                                              }
                                            },
                                            child: Text('Save'))
                                      ],
                                    );
                                  });
                            },
                          ),
                          trailing: GestureDetector(
                              child: Icon(
                                Icons.delete,
                              ),
                              onTap: () {
                                setState(() {
                                  noteList.removeAt(index);
                                });
                              })),
                    );
                  }))
        ],
      ),
    );
  }
}
