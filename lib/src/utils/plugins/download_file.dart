import 'dart:io';
import 'package:second_brain/src/utils/app_exports.dart';import 'package:dio/dio.dart';
import 'package:file_selector/file_selector.dart';
import 'package:path_provider/path_provider.dart';

class DownloadFile {
 static Dio dio = Dio();

  static Future<bool> downloadFromByte(
      {required List<int> bytes, required String fileName}) async {
    try {
      var directory = await getSaveDirectory();
      if (directory != null && directory.isNotEmpty) {
        var file = File('$directory/$fileName');
        logger.d("File Path :${file.path}");
        await file.writeAsBytes(bytes);
        logger.d('File downloaded to: ${file.path}');
        return true;
      } else {
        return false;
      }
    } catch (e, t) {
      logger.e("Error found in download from bytes function",
          error: e.toString(), stackTrace: t);
      return false;
    }
  }

  static Future<bool> downloadFromUrl({
    required String url,
    RxDouble? progress,
    Function(int received, int total)? onProgress,
  }) async {
    try {
      String fileName = url.fileName;
      var directory = await getSaveDirectory();
      if (directory != null && directory.isNotEmpty) {
        var filePath = '$directory/$fileName';
        logger.d("Download File Path :$filePath");
        await dio.download(url, filePath,
            onReceiveProgress: (received, total) {
          if (onProgress != null) {
            onProgress((received / total * 100).toInt(), total);
          }
        });
        // toast("File Successfully Downloaded", MessageEnum.success);
        return true;
      } else {
        return false;
      }
    } catch (e, t) {
      toast(e.toString(), MessageEnum.error);
      logger.e("Error found in download from bytes function",
          error: e.toString(), stackTrace: t);
      return false;
    }
  }

  static Future<String?> getSaveDirectory() async {
    var downloadsDirectory = await getDownloadsDirectory();
    final directory = await getDirectoryPath(
      confirmButtonText: 'Select Folder',
      initialDirectory: downloadsDirectory?.path,
    );
    return directory;
  }
}
