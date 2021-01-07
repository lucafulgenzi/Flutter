import 'dart:convert';
import 'dart:async';

import 'package:flutter_note_app/classes/Note.dart';
import 'package:http/http.dart' as http;

class HttpService {
  final String URL = 'http://localhost:8000/notes';

  Future<Note> addNote(String title) async {
    final http.Response response = await http.post(
      '$URL',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
    if (response.statusCode == 200) {
      return Note.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add note');
    }
  }

  Future<List<Note>> getAllNote() async {
    http.Response response = await http.get('$URL');

    if (response.statusCode == 200) {
      List<dynamic> body = jsonDecode(response.body);

      List<Note> posts = body
          .map(
            (dynamic item) => Note.fromJson(item),
          )
          .toList();

      return posts;
    } else {
      throw Exception('Failed to load notes');
    }
  }

  Future<void> deleteNote(String id) async {
    http.Response response = await http.delete("$URL/$id");

    if (response.statusCode == 200) {
    } else {
      throw Exception('Failed to remove note');
    }
  }

  Future<Note> editNote(String title, String id) async {
    final http.Response response = await http.patch(
      '$URL/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'title': title,
      }),
    );
    if (response.statusCode == 200) {
      return Note.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to edit note');
    }
  }
}
