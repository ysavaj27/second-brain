import 'package:second_brain/src/theme/dark/dark_theme.dart';
import 'package:second_brain/src/theme/light/light_theme.dart';
import 'package:second_brain/src/utils/app_exports.dart';

class AppTheme {
  AppTheme._(); // private constructor to prevent instantiation

  // Static instance for direct access
  static final AppTheme _instance = AppTheme._();

  // Static factory method to return the instance
  static AppTheme get instance => _instance;

  // appbar height = 56,back_button padding = l16,t8,b8, bottom routes bar height = 56

  static const fonts = 'lato';

  static final darkTheme = DarkTheme.theme;

  static final lightTheme = LightTheme.theme;

  static Future<void> setTheme({required ThemeMode mode}) async {
    // Get.changeThemeMode(mode);
    await prefs.setValue(key: AppKey.themeKey, value: mode.index);
  }

  static ThemeMode get getTheme {
    int theme = prefs.getValue(key: AppKey.themeKey) ?? 0;
    return ThemeMode.values[theme];
  }

  static List<BoxShadow> get boxShadow => <BoxShadow>[
        BoxShadow(
            color: AppColors.primary.withOpacity(0.5), //shadow for button
            blurRadius: 5,
            offset: const Offset(0, 2)) //blur radius of shadow
      ];

  static final defaultLightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: true,
  );
  static final redLightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.red),
    useMaterial3: true,
  );
  static final redDarkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.redAccent),
    useMaterial3: true,
  );

  static final defaultDarkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurpleAccent),
    useMaterial3: true,
  );
}
