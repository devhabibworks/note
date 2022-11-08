import 'package:note/databse/queries.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

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
}
