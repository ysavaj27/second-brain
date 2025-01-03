import 'package:firebase_core/firebase_core.dart';
import 'package:second_brain/src/modules/audio_player/audio_player_page.dart';
import 'package:second_brain/src/utils/app_exports.dart';
import 'firebase_options.dart';
import 'src/modules/home/download_screen.dart';
import 'src/modules/home/home_screen.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      // theme: AppTheme.defaultLightTheme,
      // darkTheme: AppTheme.defaultDarkTheme,
      themeMode: ThemeMode.dark,
      // home: AudioPlayerPage(),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreen(),
        '/download': (context) => DownloadScreen(),
      },
    );
  }
}
