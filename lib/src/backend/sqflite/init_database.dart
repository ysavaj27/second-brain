import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:second_brain/src/utils/plugins/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;

import 'create_database.dart';
import 'database_key.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  late Database db;

  Future<void> get database async {
    db = await _initDatabase();
  }

  static Future<Database> _initDatabase() async {
    logger.i('Init Database Called');
    String path = '';
    if (Platform.isIOS) {
      var databasesPath = await getDatabasesPath();
      path = p.join(databasesPath, 'cards.db');
    } else {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      path = documentsDirectory.path + Keys.databaseNAME;
    }

    return await openDatabase(path,
        version: Keys.databaseVERSION, onCreate: _onCreate);
  }

  static Future<File> shareDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = documentsDirectory.path + Keys.databaseNAME;
    // Share.shareXFiles([XFile(path)], text: 'Great picture');
    final file = File(path);
    final fileWithData = await file.writeAsBytes(path.codeUnits);
    return File(path);
  }

  static Future<void> _onCreate(Database db, int version) async {
    logger.i('On Table Create Called');
    await CreateDatabase.songTable(db);

  }
}