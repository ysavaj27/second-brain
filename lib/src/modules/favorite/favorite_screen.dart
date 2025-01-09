import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:second_brain/src/backend/sqflite/favorite/favorite_db.dart';
import 'package:second_brain/src/backend/sqflite/song/song_db.dart';
import 'package:second_brain/src/modules/audio_player/audio_player_page.dart';
import 'package:second_brain/src/utils/plugins/cache_image.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorites"),
      ),
      body: FutureBuilder(
        future: FavoriteDB.queryAllRows(),
        builder: (context, snapshot) {
          if (snapshot.data != null && snapshot.data!.isNotEmpty) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                var model = snapshot.data![index];
                return ListTile(
                  leading: CacheImage(
                    url: model.thumbnail,
                    width: 70,
                  ),
                  title: Text(model.name),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AudioPlayerPage(),
                      ),
                    );
                  },
                  trailing: PopupMenuButton<int>(
                    icon: Icon(Icons.more_vert),
                    onSelected: (value) async {
                      if (value == 1) {
                        // Handle the action for adding to favorites
                        await FavoriteDB.delete(model.id);
                      } else if (value == 2) {
                        // Handle the action for deleting
                        await SongDB.delete(model.id);
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
            );
          }
          if (snapshot.hasData && !snapshot.hasError) {
            return Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text("${snapshot.error.toString()}"),
            );
          }
          return Center();
        },
      ),
    );
  }
}
