import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:second_brain/src/utils/app_exports.dart';
import 'package:second_brain/src/utils/plugins/cache_image.dart';

class AudioPlayerPage extends StatefulWidget {
  final String filePath;

  const AudioPlayerPage({super.key, required this.filePath});

  @override
  State<AudioPlayerPage> createState() => _AudioPlayerPageState();
}

class _AudioPlayerPageState extends State<AudioPlayerPage> {
  late AudioPlayer _audioPlayer;
  bool _isPlaying = false;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  Color? color;

  final imageUrl =
      "https://images.pexels.com/photos/2147029/pexels-photo-2147029.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2";

  Future<void> getImageAndGeneratePalette(String url) async {
    try {
      // Initialize Dio to download the image
      Dio dio = Dio();

      // Download image as bytes
      Response response = await dio.get(
        url,
        options: Options(responseType: ResponseType.bytes),
      );

      if (response.statusCode == 200) {
        Uint8List imageBytes = response.data;

        // Decode the image to get dimensions using instantiateImageCodec
        final codec = await instantiateImageCodec(imageBytes);
        final frame = await codec.getNextFrame();
        final width = frame.image.width;
        final height = frame.image.height;
        // Generate a color palette using PaletteGenerator
        final palette = await PaletteGenerator.fromImageProvider(
          MemoryImage(imageBytes),
          size:
              Size(width.toDouble(), height.toDouble()), // Pass the dimensions
        );

        setState(() {
          color = palette.dominantColor?.color;
        });

        // Now you can use the palette for any UI element
      } else {
        logger.d("Failed to load image, status code: ${response.statusCode}");
      }
    } catch (e) {
      logger.e('Error: $e');
    }
  }

  Future<void> initializeAudioPlayer() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setFilePath(widget.filePath);
    _audioPlayer.play();
    _totalDuration = _audioPlayer.duration ?? Duration.zero;

    _audioPlayer.playingStream.listen((isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });
    });
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        setState(() {
          _currentPosition = position;
        });
      });
    });
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  @override
  void initState() {
    getImageAndGeneratePalette(imageUrl);
    initializeAudioPlayer();
    super.initState();
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
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
          // color: color,
          gradient: color != null
              ? LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    color!.withOpacity(0.7),
                    color!,
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
                  child: Center(
                    child: CacheImage(
                      url: imageUrl,
                      height: MediaQuery.of(context).size.width - 32,
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width,
                    ),
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
                        widget.filePath.fileName,
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
            SliderTheme(
              data: SliderThemeData(
                overlayShape: SliderComponentShape.noThumb,
                minThumbSeparation: 5,
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 7),
              ),
              child: Slider(
                value: _currentPosition.inMilliseconds.toDouble(),
                onChanged: (value) async {
                  await _audioPlayer
                      .seek(Duration(milliseconds: value.toInt()));
                  setState(() {});
                },
                min: 0.0,
                max: _totalDuration.inMilliseconds.toDouble(),
                activeColor: Colors.white,
                inactiveColor: Colors.white.withOpacity(0.3),
              ),
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(_currentPosition),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                Text(
                  '-${_formatDuration(_totalDuration - _currentPosition)}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ],
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
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 50,
                    ),
                  ),
                  onPressed: _togglePlayPause,
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
