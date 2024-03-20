import 'dart:convert';

import 'package:captable/src/utils/app_exports.dart';
import 'package:intl/intl.dart';

extension StringExtensions on String {
  List<String> get splitString {
    return split('|');
  }

  DateTime get showDateTime {
    return DateFormat('dd/MM/yyyy').parse(this);
  }

  // DateTime get timeDateTime {
  //   return DateFormat('hh:mm a').parse(this);
  // }

  int parseInt() {
    return int.parse(this);
  }

  double parseDouble() {
    return double.parse(this);
  }

  String get fileName {
    String fileName = split('/').last;
    return fileName;
  }

  /// Encode the string to Base64.
  String toBase64() {
    final bytes = utf8.encode(this);
    return base64.encode(bytes);
  }

  /// Decode the Base64 string.
  String fromBase64() {
    final decodedBytes = base64.decode(this);
    return utf8.decode(decodedBytes);
  }

  String get fileTypeImage {
    String fileName = split('/').last.split(".").last;
    // logger.d("File Name :$fileName");
    switch (fileName) {
      case "xlc":
        return AppAssets.xlsIc;
      case "xlsx":
        return AppAssets.xlsIc;
      case "doc":
        return AppAssets.docIc;
      case "image":
        return AppAssets.imageIc;
      case "pdf":
        return AppAssets.pdfIc;
      default:
        return AppAssets.docIc;
    }
  }
}
