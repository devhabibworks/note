import 'package:note/databse/queries.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

class SqlHelper {
  String dbName = "notedb.db";
  int dbVersion = 1;
  Database? _database;

  SqlHelper._pr();

  static SqlHelper instence = SqlHelper._pr();
  get database => inilizeDB();

  inilizeDB() async {
    if (_database != null) {
      return _database;
    } else {
      return await creaetOrOpenDB();
    }
  }

  Future<Database?> creaetOrOpenDB() async {
    String datbasePath = await getDatabasesPath();
    String path = join(datbasePath, dbName);

    return openDatabase(
      path,
      version: dbVersion,
      onCreate: (db, version) async {
        await db.execute(queryNote);
      },
    );
  }

  Future<int> insertNote(Note note) async {
    Database noteDatabae = await database;
    return await noteDatabae.insert("note", note.toMap());
  }

  insertNote2(Note note) async {
    Database noteDatabae = database;
    return await noteDatabae.rawInsert(
        ''' INSERT into note VALUES( null, "${note.title}" , "${note.body}" , "${note.date}");
''');
  }

  updateNote(Note note) async {
    Database noteDatabae = database;
    return await noteDatabae.update(
      "note",
      note.toMap(),
      where: "id = ?",
      whereArgs: [note.id],
    );
  }

  Future<int> DeleteNote(Note note) async {
    Database noteDatabae = await database;
    return await noteDatabae.delete(
      "note",
      where: "id = ? ",
      whereArgs: [
        note.id,
      ],
    );
  }

  Future<List<Map<String, dynamic>>> getAllNotes() async {
    Database notedb = await database;
    return notedb.rawQuery('select * from note order by id desc ');
  }
}
