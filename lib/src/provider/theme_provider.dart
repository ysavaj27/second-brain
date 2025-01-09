import 'package:second_brain/src/utils/app_exports.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;

  ThemeMode get themeMode => _themeMode;

  Future<void> changeTheme(ThemeMode mode) async {
    _themeMode = mode;
    await setTheme(mode: mode);
    notifyListeners();
  }

  Future<void> setTheme({required ThemeMode mode}) async {
    await prefs.setValue(key: AppKey.themeKey, value: mode.index);
  }

  Future<void>  getTheme() async {
    int theme = await prefs.getValue(key: AppKey.themeKey) ?? 0;
    _themeMode = ThemeMode.values[theme];
  }
}
