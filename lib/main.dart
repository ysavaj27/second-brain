import 'package:second_brain/src/models/init/init_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:second_brain/src/utils/app_exports.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.defaultLightTheme,
      darkTheme: AppTheme.defaultDarkTheme,
      themeMode: ThemeMode.light,
      home: InitPage(),
    );
  }
}
