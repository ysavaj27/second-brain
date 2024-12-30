import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:second_brain/src/utils/widgets/app_popup.dart';
import '../utils/app_exports.dart';

final InitConfig init = InitConfig.instance;

class InitConfig extends GetxService {
  static final InitConfig instance = InitConfig();

  Future<void> init() async {
    await _initLocalStorage();
     _setOrientation();
    // _getLanguage();
  }

  Future<void> initConfig() async {
    await app.getUser();
    dioConfig.init();
    await networkCheck();
    await _getDeviceInfo();
    await _getPackageInfo();
  }

  String packageName = 'Not Available';
  String packageVersion = '0.0.0+0';

  String deviceModel = 'Not Available';
  String deviceOs = 'Not Available';
  Rx<ThemeMode> themeMode = AppTheme.getTheme.obs;

  static _initLocalStorage() async {
    try {
      logger.d('INITING GET STORAGE');
      await Get.putAsync(() => PrefConfig().init());
    } catch (e) {
      logger.e(e);
    }
  }

  static void _setOrientation()  {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  }

  Future<void> _getPackageInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    packageName = packageInfo.packageName;
    packageVersion = '${packageInfo.version}+${packageInfo.buildNumber}';
  }

  Future<void> networkCheck() async {
    // logger.i('check network');
    Connectivity()
        .onConnectivityChanged
        .listen((List<ConnectivityResult> result) {
      // logger.wtf(result);
      if (result.isNotEmpty && result.first == ConnectivityResult.none) {
        appPopUp(barrierDismissible: false, children: [
          const SizedBox(height: 10),
          const SpinKitPouringHourGlassRefined(color: Colors.white),
          const SizedBox(height: 20),
          Text(
            "Network Connection Lost..! \n Please Reconnect..",
            style: Get.context?.textTheme.labelMedium
                ?.copyWith(fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 10),
        ]);
      } else if (result.isNotEmpty && result.first != ConnectivityResult.none) {
        if (Get.context != null) {
          Get.back();
        }
      }
    });
  }

  Future<void> _getDeviceInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    switch (Platform.operatingSystem) {
      case 'android':
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        deviceModel = androidInfo.model;
        deviceOs = '${androidInfo.version}';
        break;
      case 'ios':
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        deviceModel = iosInfo.utsname.machine;
        deviceOs = '${iosInfo.systemName} (${iosInfo.systemVersion})';
        break;
      case 'windows':
        WindowsDeviceInfo iosInfo = await deviceInfo.windowsInfo;
        deviceModel = iosInfo.computerName;
        deviceOs = '${iosInfo.productName} (${iosInfo.displayVersion})';
        break;
      default:
        WebBrowserInfo webBrowserInfo = await deviceInfo.webBrowserInfo;
        deviceModel = webBrowserInfo.userAgent ?? 'Unknown';
        deviceOs = Platform.operatingSystemVersion;
    }
  }

// static _firebaseInit() async {
//   try {
//     await Firebase.initializeApp();
//     logger.d('INITING FIREBASE');
//   } catch (e) {
//     logger.e(e);
//   }
// }

// ABOUT TRANSLATION

// TranslationModel _translation = TranslationModel.fromJson({});
//
// TranslationModel get translation => _translation;
//
// set translation(TranslationModel translation) {
//   _translation = translation;
//   prefs.setValue(key: AppKey.languageKey, value: translation.languageCode);
// }

// void _getLanguage() {
//   try {
//     var languageCode = prefs.getValue(key: AppKey.languageKey);
//     for (var locale in Translation.locales) {
//       if (locale.languageCode == languageCode) {
//         _translation = locale;
//         break;
//       }
//     }
//     if (_translation.isEmpty) translation = Translation.locales.first;
//
//     logger.f(
//         '${translation.countryCode}-${translation.languageCode}  && ${translation.languageName}');
//   } catch (e, t) {
//     logger.e('Locale', error: e, stackTrace: t);
//   }
// }
}
