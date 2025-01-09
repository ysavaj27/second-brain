import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:second_brain/src/provider/player_provider.dart';
import 'package:second_brain/src/provider/theme_provider.dart';
import 'package:second_brain/src/utils/app_exports.dart';
import 'firebase_options.dart';
import 'src/backend/sqflite/init_database.dart';
import 'src/modules/home/download_screen.dart';
import 'src/modules/home/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init.init();
  await PrefConfig.instance.init();
  await DatabaseHelper.instance.database;
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()..getTheme()),
        ChangeNotifierProvider(create: (_) => PlayerProver()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (BuildContext context, ThemeProvider value, Widget? child) {
          return MaterialApp.router(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            // theme: AppTheme.lightTheme,
            // darkTheme: AppTheme.darkTheme,
            // themeMode: value.themeMode,
            // home: AudioPlayerPage(),
            routerConfig: Pages().router,
          );
        },
      ),
    );
  }
}
