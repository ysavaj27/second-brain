import 'package:second_brain/src/backend/sqflite/database_key.dart';
import 'package:second_brain/src/backend/sqflite/init_database.dart';
import 'package:second_brain/src/models/song/favorite_model.dart';
import 'package:second_brain/src/models/song/song_model.dart';
import 'package:second_brain/src/utils/plugins/logger.dart';
import 'package:sqflite/sqflite.dart';

class FavoriteDB {
  static Future<int> insert(FavoriteModel model) async {
    try {
      Database db = DatabaseHelper.instance.db;
      logger.i('Fav :${model.toAdd()}');
      var res = await db.insert(Keys.favoriteCol, model.toAdd(),
          conflictAlgorithm: ConflictAlgorithm.ignore);
      return res;
    } on Exception catch (e, t) {
      logger.e('Error : $e \nTrace :$t');
      return 0;
    }
  }

  static Future<int> delete(int id) async {
    try {
      Database db = DatabaseHelper.instance.db;
      var res = await db.delete(Keys.favoriteCol,
          where: "${Keys.songId} = ?", whereArgs: [id]);
      return res;
    } on Exception catch (e, t) {
      logger.e('Error : $e \nTrace :$t');
      return 0;
    }
  }

  static Future<List<SongModel>> queryAllRows() async {
    try {
      Database db = DatabaseHelper.instance.db;
      var data =
          await db.rawQuery('''SELECT ${Keys.songCol}. * FROM ${Keys.songCol} 
          INNER JOIN ${Keys.favoriteCol} ON ${Keys.songCol}.${Keys.id} = ${Keys.favoriteCol}.${Keys.songId} 
          WHERE ${Keys.songCol}.${Keys.status} = ? ''', [1]);
      // var data = await db
      //     .query(Keys.songCol, where: "${Keys.status} = ?", whereArgs: [1]);
      List<SongModel> list = [];
      data.map((e) {
        logger.i('Model :$e');
        list.add(SongModel.fromJson(e));
      }).toList();
      // logger.d('Fav song List length :${data.length}');
      return list;
    } on Exception catch (e, t) {
      logger.e('Error : $e \nTrace :$t');
      return [];
    }
  }

}
