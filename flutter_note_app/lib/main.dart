import 'package:flutter/material.dart';
import 'package:flutter_note_app/classes/Note.dart';
import 'package:flutter_note_app/services/note_service.dart';

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

  Future<Note> _futureNote;
  final HttpService note_service = HttpService();

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
                                note_service.addNote(myController.text);
                                myController.clear();
                              });
                            }
                          }),
                    ),
                  ),
                ],
              )),
          Expanded(
              child: FutureBuilder(
            future: note_service.getAllNote(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Note>> snapshot) {
              if (snapshot.hasData) {
                List<Note> notes = snapshot.data;
                return ListView(
                  children: notes
                      .map((Note note) => Card(
                            child: ListTile(
                                title: Text(note.title),
                                leading: GestureDetector(
                                  child: Icon(Icons.edit),
                                  onTap: () {
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
                                                        note_service.editNote(
                                                            dialogController
                                                                .text,
                                                            note.id);
                                                        dialogController
                                                            .clear();
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
                                        note_service.deleteNote(note.id);
                                      });
                                    })),
                          ))
                      .toList(),
                );
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            },
          ))
        ],
      ),
    );
  }
}
