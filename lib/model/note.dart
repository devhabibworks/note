class Note {
  var id;
  var title;
  var body;
  var date;

  Note({this.id, this.title, this.body, this.date});

  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    title = map['title'];
    body = map['body'];
    date = map['date'];
  }

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "title": title,
      "body": body,
      "date": date,
    };
  }
}
