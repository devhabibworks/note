import '../../../model/note.dart';

enum TYPE { NEW, UPDATE }

class NoteArgument {
  Note? note;
  TYPE type;

  NoteArgument({required this.type, this.note});
}
