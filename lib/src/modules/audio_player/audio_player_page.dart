import 'package:provider/provider.dart';
import 'package:second_brain/src/provider/player_provider.dart';
import 'package:second_brain/src/utils/app_exports.dart';

class AudioPlayerPage extends StatefulWidget {
  const AudioPlayerPage({super.key});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<PlayerProver>(context, listen: false);
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.keyboard_arrow_down_outlined,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        title: Text(
          "Repeat Rewind",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.more_horiz,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: provider.song.color.isNotEmpty
              ? LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color(provider.song.color).withOpacity(0.7),
                    Color(provider.song.color),
                  ],
                )
              : null,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 130),
            Expanded(
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CacheImage(
                    url: provider.song.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        provider.song.name,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          height: 1.1,
                        ),
                      ),
                      // Text(
                      //   "Arjit singh",
                      //   style: TextStyle(
                      //     fontSize: 20,
                      //     fontWeight: FontWeight.w500,
                      //     color: Colors.grey,
                      //     height: 1.1,
                      //   ),
                      // ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.add_circle_outline,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
            SizedBox(height: 25),
            Consumer<PlayerProver>(
              builder: (context, value, child) {
                return SliderTheme(
                  data: SliderThemeData(
                    overlayShape: SliderComponentShape.noThumb,
                    minThumbSeparation: 5,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
                  ),
                  child: Slider(
                    value: value.currentPosition.inMilliseconds.toDouble(),
                    onChanged: (val) async {
                      await value.audioPlayer
                          .seek(Duration(milliseconds: val.toInt()));
                    },
                    min: 0.0,
                    max: value.totalDuration.inMilliseconds.toDouble(),
                    activeColor: Colors.white,
                    inactiveColor: Colors.white.withOpacity(0.3),
                  ),
                );
              },
            ),
            SizedBox(height: 5),
            Consumer<PlayerProver>(
              builder: (context, value, child) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      _formatDuration(value.currentPosition),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      '-${_formatDuration(provider.totalDuration - value.currentPosition)}',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              },
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.shuffle),
                  iconSize: 30,
                  onPressed: () {},
                  color: Colors.white,
                ),
                IconButton(
                  icon: Icon(Icons.skip_previous),
                  iconSize: 40,
                  onPressed: () {},
                  color: Colors.white,
                ),
                IconButton(
                  icon: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Consumer<PlayerProver>(
                      builder: (context, value, child) {
                        return Icon(
                          value.isPlaying ? Icons.pause : Icons.play_arrow,
                          size: 50,
                        );
                      },
                    ),
                  ),
                  onPressed: provider.togglePlayPause,
                  color: Colors.black,
                ),
                IconButton(
                  icon: Icon(Icons.skip_next),
                  iconSize: 40,
                  onPressed: () {},
                  color: Colors.white,
                ),
                IconButton(
                  // icon: Icon(Icons.timer_outlined),
                  icon: Icon(Icons.favorite_border),
                  iconSize: 30,
                  onPressed: () {},
                  color: Colors.white,
                ),
              ],
            ),
            SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
