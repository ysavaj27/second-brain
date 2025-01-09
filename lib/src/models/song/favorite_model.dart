import 'package:second_brain/src/backend/sqflite/database_key.dart';

class FavoriteModel {
  int id;
  int songId;

  FavoriteModel({
    this.id = 0,
    this.songId = 0,
  });

  factory FavoriteModel.fromJson(Map<String, dynamic> json) {
    return FavoriteModel(
      id: json[Keys.id] ?? 0,
      songId: json[Keys.songId] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Keys.id: id,
      Keys.songId: songId,
    };
  }

  Map<String, dynamic> toAdd() {
    return {
      Keys.id: null,
      Keys.songId: songId,
    };
  }
}
