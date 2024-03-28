import 'package:second_brain/src/utils/app_exports.dart';

class AppTheme {
  AppTheme._(); // private constructor to prevent instantiation

  // Static instance for direct access
  static final AppTheme _instance = AppTheme._();

  // Static factory method to return the instance
  static AppTheme get instance => _instance;

  // appbar height = 56,back_button padding = l16,t8,b8, bottom routes bar height = 56

  static const fonts = 'lato';

  static final darkTheme = ThemeData(
    fontFamily: fonts,
    iconTheme: const IconThemeData(color: Colors.white),
    primarySwatch: Colors.grey,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    ),
    scaffoldBackgroundColor: Colors.black,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(fontFamily: fonts),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontFamily: fonts,
        fontSize: 40,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
          fontFamily: fonts, fontSize: 20, fontWeight: FontWeight.bold),
      labelLarge: TextStyle(
        fontFamily: fonts,
        fontSize: 20,
        fontWeight: FontWeight.normal,
      ),
      labelMedium: TextStyle(
        fontFamily: fonts,
        fontSize: 16,
        fontWeight: FontWeight.normal,
      ),
      labelSmall: TextStyle(
        fontFamily: fonts,
        letterSpacing: 0.7,
        fontSize: 14,
        fontWeight: FontWeight.normal,
      ),
    ),
  );

  static final lightTheme = ThemeData(
    fontFamily: fonts,
    useMaterial3: false,
    iconTheme: const IconThemeData(color: Colors.black),
    primarySwatch: Colors.grey,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      elevation: 0,
      color: Colors.transparent,
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    ),
    scaffoldBackgroundColor: Colors.white,
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        textStyle: const TextStyle(
          fontFamily: fonts,
          fontWeight: FontWeight.w600,
          color: AppColors.primary,
          fontSize: 15,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        minimumSize: const Size(95, 30),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        textStyle: TextStyle(
          color: Get.theme.scaffoldBackgroundColor,
        ),
      ),
    ),
    textTheme: const TextTheme(
      headlineMedium: TextStyle(
        fontFamily: fonts,
        fontSize: 40,
        color: Colors.black,
        fontWeight: FontWeight.bold,
      ),
      headlineSmall: TextStyle(
        fontFamily: fonts,
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      labelLarge: TextStyle(
        fontFamily: fonts,
        fontSize: 20,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      labelMedium: TextStyle(
        fontFamily: fonts,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
      labelSmall: TextStyle(
        fontFamily: fonts,
        letterSpacing: 0.7,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: Colors.black,
      ),
    ),
  );

  static Future<void> setTheme({required ThemeMode mode}) async {
    Get.changeThemeMode(mode);
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
