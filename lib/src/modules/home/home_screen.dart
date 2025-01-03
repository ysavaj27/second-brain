import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:path_provider/path_provider.dart';
import 'package:second_brain/src/modules/audio_player/audio_player_page.dart';
import 'package:second_brain/src/utils/app_exports.dart';
import 'dart:io';

import 'player_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<File> _audioFiles = [];
  List<File> _videoFiles = [];

  @override
  void initState() {
    super.initState();
    _loadDownloadedFiles();
  }

  Future<void> _loadDownloadedFiles() async {
    var appDir = await getApplicationDocumentsDirectory();
    var files = Directory(appDir.path).listSync().whereType<File>().toList();

    setState(() {
      _audioFiles = files.where((file) => file.path.endsWith('.mp3')).toList();
      _videoFiles = files.where((file) => file.path.endsWith('.mp4')).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloaded Files'),
        actions: [
          IconButton(
            icon: Icon(Icons.download),
            onPressed: () {
              Navigator.pushNamed(context, '/download');
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadDownloadedFiles(),
        child: ListView(
          children: [
            if (_audioFiles.isNotEmpty)
              ListTile(
                  title: Text('Audio Files',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ..._audioFiles.map(
              (file) => ListTile(
                title: Text(file.path.split('/').last),
                trailing: Icon(Icons.play_arrow),
                onLongPress: () {
                  // OpenFilex.open("/sdcard/example.txt");
                },
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AudioPlayerPage(filePath: file.path),
                    ),
                  );
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) =>
                  //         PlayerScreen(filePath: file.path),
                  //   ),
                  // );
                },
              ),
            ),
            if (_videoFiles.isNotEmpty)
              ListTile(
                  title: Text('Video Files',
                      style: TextStyle(fontWeight: FontWeight.bold))),
            ..._videoFiles.map(
              (file) => ListTile(
                title: Text(file.path.split('/').last),
                trailing: Icon(Icons.play_arrow),
                onLongPress: () {
                  // OpenFilex.open(file.path);
                },
                onTap: () {
                  logger.d(file.path);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PlayerScreen(filePath: file.path),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
