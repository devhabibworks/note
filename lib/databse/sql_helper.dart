import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../model/note.dart';

class SqlHelper {
  final String dbName = "notedb.db";
  final int dbVersion = 1;
  SqlHelper._privateConstractor();
  static SqlHelper instance = SqlHelper._privateConstractor();

  Database? _database;
  get database => inilizeDB();

  inilizeDB() async {
    if (_database != null) {
      return _database;
    } else {
      return await createOrOpenDB();
    }
  }

  Future<Database> createOrOpenDB() async {
    // to get the database path to be stored
    var databsaPath = await getDatabasesPath();
    // example  storate/android/data/com.example.note/notedb.db
    String path = join(databsaPath, dbName);

    // this will open databse or create on if not exists
    return await openDatabase(path, version: dbVersion,
        onCreate: ((db, version) async {
      // this code will create the table only for ones
      String query = '''
         CREATE TABLE if NOT EXISTS note(
         ID INTEGER  PRIMARY KEY  AUTOINCREMENT , 
         TITLE TEXT,
         BODY TEXT NOT NULL,
         DATE TEXT NOT NULL  );
       ''';

      await db.execute(query);
    }));
  }

// used to insert new Note
  Future<int> insertNote(Note note) async {
    Database noteDb = await database;
    return noteDb.insert("note", note.toMap());
  }

// used to update note
  Future<int> updateNote(Note note) async {
    Database noteDb = await database;
    return noteDb
        .update("note", note.toMap(), where: 'id = ?', whereArgs: [note.id]);
  }

// used to remove note
  Future<int> removeNote(Note note) async {
    Database noteDb = await database;
    return noteDb.delete("note", where: 'id = ?', whereArgs: [note.id]);
  }

// this function used to get all notes
  Future<List<Map<String, dynamic>>> getAllNote(Note note) async {
    Database noteDb = await database;
    return noteDb.rawQuery(''' SELECT * from note ''');
  }

  // used to get the row numbers on column note
  Future<int?> getNoteCount(Note note) async {
    Database noteDb = await database;
    return Sqflite.firstIntValue(
        await noteDb.rawQuery('SELECT COUNT(*) FROM note'));
  }
}
