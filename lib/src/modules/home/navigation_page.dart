import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:second_brain/src/modules/audio_player/audio_player_page.dart';
import 'package:second_brain/src/provider/player_provider.dart';
import 'package:second_brain/src/utils/app_exports.dart';

class NavigationPage extends StatefulWidget {
  final Widget child;

  const NavigationPage({super.key, required this.child});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int val) {
    switch (val) {
      case 0:
        context.go(Routes.home);
        break;
      case 1:
        context.go(Routes.download);
      case 2:
        context.go(Routes.favorite);
        break;
      default:
        context.go(Routes.home);
        break;
    }
    setState(() {
      _selectedIndex = val;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        mainAxisSize: MainAxisSize.min,
        children: [
          Consumer<PlayerProver>(
            builder: (context, value, child) {
              return InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AudioPlayerPage(),
                    ),
                  );
                },
                child: Visibility(
                  visible: value.song.id.isNotEmpty,
                  child: Container(
                    width: 450,
                    height: 60,
                    margin: EdgeInsets.all(4),
                    padding: EdgeInsets.fromLTRB(8, 4, 4, 4),
                    decoration: BoxDecoration(
                      color: Color(value.song.color),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CacheImage(
                                url: value.song.thumbnail,
                              ),
                              SizedBox(width: 5),
                              Expanded(
                                child: Text(
                                  value.song.name,
                                  maxLines: 1,
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: value.togglePlayPause,
                                icon: Icon(
                                  value.isPlaying
                                      ? Icons.pause
                                      : Icons.play_arrow,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 2),
                        SliderTheme(
                          data: SliderThemeData(
                            overlayShape: SliderComponentShape.noThumb,
                            minThumbSeparation: 0,
                            trackHeight: 2,
                            thumbShape:
                                RoundSliderThumbShape(enabledThumbRadius: 0),
                          ),
                          child: Slider(
                            value:
                                value.currentPosition.inMilliseconds.toDouble(),
                            onChanged: (v) async {
                              await value.audioPlayer
                                  .seek(Duration(milliseconds: v.toInt()));
                            },
                            min: 0.0,
                            max: value.totalDuration.inMilliseconds.toDouble(),
                            activeColor: Colors.white,
                            inactiveColor: Colors.white.withOpacity(0.3),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 4),
          NavigationBar(
            onDestinationSelected: _onItemTapped,
            selectedIndex: _selectedIndex,
            indicatorColor: Colors.amber,
            destinations: const <Widget>[
              NavigationDestination(
                selectedIcon: Icon(Icons.home),
                icon: Icon(Icons.home_outlined),
                label: 'Home',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.download),
                icon: Icon(Icons.download_outlined),
                label: 'Download',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.favorite),
                icon: Icon(Icons.favorite_border),
                label: 'Favorite',
              ),
              NavigationDestination(
                selectedIcon: Icon(Icons.settings),
                icon: Icon(Icons.settings_outlined),
                label: 'Setting',
              ),
            ],
          ),
        ],
      ),
    );
  }
}
