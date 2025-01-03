import 'package:sqflite/sqflite.dart';

import 'database_key.dart';

class CreateDatabase {
  static Future<void> songTable(Database db) async {
    return await db.execute('''
          CREATE TABLE ${Keys.songCol} (
            ${Keys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${Keys.userId} INTEGER NOT NULL,
            ${Keys.name} TEXT NOT NULL,
            ${Keys.filepath} TEXT NOT NULL,
            ${Keys.thumbNail} TEXT NOT NULL,
            ${Keys.status} INTEGER NOT NULL
          )
          ''');
  }

}
