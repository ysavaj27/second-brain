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
            ${Keys.color} INTEGER NOT NULL,
            ${Keys.status} INTEGER NOT NULL
          )
          ''');
  }

  static Future<void> favoriteTable(Database db) async {
    return await db.execute('''
          CREATE TABLE IF NOT EXISTS ${Keys.favoriteCol} (
            ${Keys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
            ${Keys.songId} INTEGER NOT NULL,
            FOREIGN KEY (${Keys.songId}) REFERENCES ${Keys.songCol}(${Keys.id}) ON DELETE CASCADE
          )
          ''');
  }

  static Future<void> playlistsTable(Database db) async {
    return await db.execute('''
    CREATE TABLE IF NOT EXISTS ${Keys.playlistsCol} (
      ${Keys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Keys.name} TEXT NOT NULL
    )
  ''');
  }

  static Future<void> playlistSongsTable(Database db) async {
    return await db.execute('''
    CREATE TABLE IF NOT EXISTS ${Keys.playlistSongsCol} (
      ${Keys.id} INTEGER PRIMARY KEY AUTOINCREMENT,
      ${Keys.playlistId} INTEGER NOT NULL,
      ${Keys.songId} INTEGER NOT NULL,
      FOREIGN KEY (${Keys.playlistId}) REFERENCES ${Keys.playlistsCol}(${Keys.id}) ON DELETE CASCADE,
      FOREIGN KEY (${Keys.songId}) REFERENCES ${Keys.songCol}(${Keys.id}) ON DELETE CASCADE
    )
  ''');
  }
}
