import 'package:second_brain/src/backend/sqflite/database_key.dart';

class SongModel {
   int id;
   int userId;
   String name;
   String filePath;
   String thumbnail;
   int color;
   int status;

  SongModel({
    this.id = 0,
    this.userId = 0,
    this.name = '',
    this.filePath = '',
    this.thumbnail = '',
    this.color = 0,
    this.status = 0,
  });

  factory SongModel.fromJson(Map<String, dynamic> json) {
    return SongModel(
      id: json[Keys.id] ?? 0,
      userId: json[Keys.userId] ?? 0,
      name: json[Keys.name] ?? "",
      filePath: json[Keys.filepath] ?? "",
      thumbnail: json[Keys.thumbNail] ?? "",
      color: json[Keys.color] ?? 0,
      status: json[Keys.status] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      Keys.id: id,
      Keys.userId: userId,
      Keys.name: name,
      Keys.filepath: filePath,
      Keys.thumbNail: thumbnail,
      Keys.color: color,
      Keys.status: status,
    };
  }
  Map<String, dynamic> toAdd() {
    return {
      Keys.id: null,
      Keys.userId: userId,
      Keys.name: name,
      Keys.filepath: filePath,
      Keys.thumbNail: thumbnail,
      Keys.color: color,
      Keys.status: status,
    };
  }
}
