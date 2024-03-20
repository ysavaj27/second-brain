import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:math';

extension Formatte on int {
  double get convertToMB {
    return this / 1024 / 1024;
  }

  String get weekName {
    switch (this) {
      case 1:
        return 'M';
      case 2:
        return 'T';
      case 3:
        return 'W';
      case 4:
        return 'T';
      case 5:
        return 'F';
      case 6:
        return 'S';
      case 7:
        return 'S';
      default:
        return '';
    }
  }

  String get fileSize {
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    if (this == 0) return '0 ${suffixes[0]}';
    var i = (log(this) / log(1024)).floor();
    return "${(this / pow(1024, i)).toStringAsFixed(1)} ${suffixes[i]}";
  }

  String get monthName {
    switch (this) {
      case 1:
        return 'jan'.tr;
      case 2:
        return 'feb'.tr;
      case 3:
        return 'mar'.tr;
      case 4:
        return 'apr'.tr;
      case 5:
        return 'may'.tr;
      case 6:
        return 'jun'.tr;
      case 7:
        return 'jul'.tr;
      case 8:
        return 'aug'.tr;
      case 9:
        return 'sep'.tr;
      case 10:
        return 'oct'.tr;
      case 11:
        return 'nov'.tr;
      case 12:
        return 'dec'.tr;
      default:
        return '';
    }
  }

  String get alphaBets {
    return String.fromCharCode(this + 65);
  }

  bool get success => this == 1 ? true : false;

  bool get isNotEmpty => this == 0 ? false : true;

  bool get isEmpty => this == 0 ? true : false;

  String get show => this == 0 ? "" : '$this';
}

extension FancyNum on num {
  num plus(num other) => this + other;

  num times(num other) => this * other;

  num get percentageOf10 => (this * 10) / 100;

  String get toCurrency {
    var format = NumberFormat("#,##0");
    return format.format(this);
  }

  double toPrecisions(int n) => double.parse(toStringAsFixed(n));
}
