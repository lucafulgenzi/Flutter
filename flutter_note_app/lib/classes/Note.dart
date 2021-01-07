class Note {
  final String id;
  final String title;

  Note({this.id, this.title});

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json['_id'],
      title: json['title'],
    );
  }
}
