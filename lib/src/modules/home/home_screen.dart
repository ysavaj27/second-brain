import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:second_brain/src/backend/sqflite/favorite/favorite_db.dart';
import 'package:second_brain/src/backend/sqflite/song/song_db.dart';
import 'package:second_brain/src/models/song/favorite_model.dart';
import 'package:second_brain/src/models/song/song_model.dart';
import 'package:second_brain/src/modules/audio_player/audio_player_page.dart';
import 'package:second_brain/src/modules/favorite/favorite_screen.dart';
import 'package:second_brain/src/modules/home/download_screen.dart';
import 'package:second_brain/src/provider/player_provider.dart';
import 'package:second_brain/src/utils/app_exports.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<SongModel> _audioFiles = [];

  @override
  void initState() {
    super.initState();
    _loadDownloadedFiles();
  }

  Future<void> _loadDownloadedFiles() async {
    _audioFiles = await SongDB.queryAllRows();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Downloaded Files'),
        actions: [
          // IconButton(
          //   icon: Icon(Icons.favorite),
          //   onPressed: () {
          //
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(builder: (context) => FavoriteScreen()),
          //     );
          //   },
          // ),
        ],
      ),
      body: RefreshIndicator(
          onRefresh: () => _loadDownloadedFiles(),
          child: ListView.builder(
            itemCount: _audioFiles.length,
            physics: BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              var model = _audioFiles[index];
              return ListTile(
                leading: CacheImage(
                  url: model.thumbnail,
                  width: 70,
                ),
                title: Text(model.name),
                onTap: () {
                  Provider.of<PlayerProver>(context, listen: false)
                      .initializeAudioPlayer(model);
                  // context.go(Routes.song,extra: model);
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AudioPlayerPage(),
                  //   ),
                  // );
                },
                trailing: PopupMenuButton<int>(
                  icon: Icon(Icons.more_vert),
                  onSelected: (value) async {
                    if (value == 1) {
                      // Handle the action for adding to favorites
                      await FavoriteDB.insert(
                        FavoriteModel(songId: model.id),
                      );
                      _loadDownloadedFiles();
                    } else if (value == 2) {
                      // Handle the action for deleting
                      await SongDB.delete(model.id);
                      _loadDownloadedFiles();
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<int>(
                        value: 1,
                        child: Row(
                          children: [
                            Icon(Icons.favorite, color: Colors.green),
                            SizedBox(width: 8),
                            Text('Favorites'),
                          ],
                        ),
                      ),
                      PopupMenuItem<int>(
                        value: 2,
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: Colors.red),
                            SizedBox(width: 8),
                            Text('Delete'),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              );
            },
          )),
    );
  }
}
