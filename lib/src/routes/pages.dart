import 'package:go_router/go_router.dart';
import 'package:second_brain/src/modules/audio_player/audio_player_page.dart';
import 'package:second_brain/src/modules/favorite/favorite_screen.dart';
import 'package:second_brain/src/modules/home/download_screen.dart';
import 'package:second_brain/src/modules/home/home_screen.dart';
import 'package:second_brain/src/modules/home/navigation_page.dart';
import 'package:second_brain/src/modules/splash/splash_screen.dart';
import 'package:second_brain/src/utils/app_exports.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> shellNavigatorKey = GlobalKey<NavigatorState>();

class Pages {
  final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: Routes.init,
    routes: [
      GoRoute(
        path: Routes.init,
        parentNavigatorKey: rootNavigatorKey,
        builder: (context, state) => SplashScreen(),
      ),
      ShellRoute(
        navigatorKey: shellNavigatorKey,
        builder: (context, state, child) => NavigationPage(child: child),
        routes: [
          GoRoute(
              path: '/home',
              parentNavigatorKey: shellNavigatorKey,
              builder: (context, state) => HomeScreen(),
              routes: [
                GoRoute(
                  path: Routes.song,
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => AudioPlayerPage(),
                ),
              ]),
          GoRoute(
            parentNavigatorKey: shellNavigatorKey,
            path: '/favorite',
            builder: (context, state) => FavoriteScreen(),
          ),
          GoRoute(
            path: Routes.download,
            parentNavigatorKey: shellNavigatorKey,
            builder: (context, state) => DownloadScreen(),
          ),
        ],
      ),

      // GoRoute(
      //     path: Routes.navigation,
      //     builder: (context, state) => NavigationPage(child:state,),
      //     routes: [
      //       GoRoute(
      //         path: Routes.download,
      //         builder: (context, state) => DownloadScreen(),
      //       ),
      //     ]),
      // Home route with BottomNavigationBar
    ],
    // redirect: (context, state) {
    //   if (state.uri.toString() == '/') {
    //     return '/';
    //   }
    //   return null;
    // },
  );
}
