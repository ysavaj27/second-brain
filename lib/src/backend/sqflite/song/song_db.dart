import 'package:flutter/cupertino.dart';
import 'package:second_brain/src/backend/sqflite/database_key.dart';
import 'package:second_brain/src/backend/sqflite/init_database.dart';
import 'package:second_brain/src/models/song/song_model.dart';
import 'package:second_brain/src/utils/plugins/logger.dart';
import 'package:sqflite/sqflite.dart';

class SongDB {
  static Future<int> insert(SongModel model) async {
    try {
      Database db = DatabaseHelper.instance.db;
      logger.i('Insert Insights :${model.toAdd()}');
      var res = await db.insert(Keys.songCol, model.toAdd());
      return res;
    } on Exception catch (e, t) {
      logger.e('Error : $e \nTrace :$t');
      return 0;
    }
  }

  static Future<int> delete(int id) async {
    try {
      Database db = DatabaseHelper.instance.db;
      var res = await db.update(Keys.songCol, {Keys.status: 0},
          where: "${Keys.id} = ?", whereArgs: [id]);
      return res;
    } on Exception catch (e, t) {
      logger.e('Error : $e \nTrace :$t');
      return 0;
    }
  }

  static Future<List<SongModel>> queryAllRows() async {
    try {
      Database db = DatabaseHelper.instance.db;
      // var data = await db
      //     .query(Keys.songCol, where: "${Keys.status} = ?", whereArgs: [1]);

      var data = await db.rawQuery('''
  SELECT 
    ${Keys.songCol}.*, 
    CASE 
      WHEN ${Keys.favoriteCol}.${Keys.id} IS NOT NULL THEN 1 
      ELSE 0 
    END AS isFavorite
  FROM ${Keys.songCol}
  LEFT JOIN ${Keys.favoriteCol} 
    ON ${Keys.songCol}.${Keys.id} = ${Keys.favoriteCol}.${Keys.songId}
  WHERE ${Keys.songCol}.${Keys.status} = ?
''', [1]);

      List<SongModel> list = [];
      data.map((e) {
        logger.i(e);
        list.add(SongModel.fromJson(e));
      }).toList();
      logger.d(list.map((e) => e.toJson()).toList());
      return list;
    } on Exception catch (e, t) {
      logger.e('Error : $e \nTrace :$t');
      return [];
    }
  }
}
