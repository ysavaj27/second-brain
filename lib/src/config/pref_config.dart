import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

final PrefConfig prefs = PrefConfig.instance;

class PrefConfig extends GetxService {
  static final PrefConfig instance = PrefConfig();

  late SharedPreferences _prefs;

  // Initialize SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  dynamic getValue({required String key}) {
    return _prefs.get(key);
  }

  // Method to set a value
  Future<void> setValue({required String key, dynamic value}) async {
    if (value is String) {
      await _prefs.setString(key, value);
    } else if (value is int) {
      await _prefs.setInt(key, value);
    } else if (value is double) {
      await _prefs.setDouble(key, value);
    } else if (value is bool) {
      await _prefs.setBool(key, value);
    } else if (value == null) {
      await _prefs.remove(key);
    }
  }

  Future<void> removeValue({required String key}) async {
    await _prefs.remove(key);  // Remove value from SharedPreferences
  }
}
