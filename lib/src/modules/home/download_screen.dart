import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:path_provider/path_provider.dart';
import 'package:second_brain/src/backend/sqflite/create_database.dart';
import 'package:second_brain/src/backend/sqflite/song/song_db.dart';
import 'package:second_brain/src/models/song/song_model.dart';
import 'package:second_brain/src/utils/app_exports.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  _DownloadScreenState createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  final TextEditingController _urlController = TextEditingController();
  bool _isFetching = false;
  bool _isDownloading = false;
  String? _videoTitle;
  String? _videoThumbnail;
  List<AudioOnlyStreamInfo> _audioFormats = [];
  List<MuxedStreamInfo> _videoFormats = [];
  AudioOnlyStreamInfo? _selectedAudioFormat;
  MuxedStreamInfo? _selectedVideoFormat;
  double _progress = 0.0;
  final YoutubeExplode _youtube = YoutubeExplode();
  Dio dio = Dio();

  Future<void> fetchMetadata(String url) async {
    try {
      setState(() {
        _isFetching = true;
        _videoTitle = null;
        _videoThumbnail = null;
        _audioFormats = [];
        _videoFormats = [];
        _selectedAudioFormat = null;
        _selectedVideoFormat = null;
      });

      var video = await _youtube.videos.get(url);
      var manifest = await _youtube.videos.streamsClient.getManifest(video.id);

      setState(() {
        _videoTitle = video.title;
        _videoThumbnail = video.thumbnails.highResUrl;
        _audioFormats = manifest.audioOnly.toList();
        _videoFormats = manifest.muxed.toList();
        if (_videoFormats.isNotEmpty) {
          _selectedVideoFormat = _videoFormats.first;
        }
        if (_audioFormats.isNotEmpty) {
          _selectedAudioFormat = _audioFormats.first;
        }
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error fetching metadata: $e'),
      ));
    } finally {
      setState(() {
        _isFetching = false;
      });
    }
  }

  Future<void> downloadFile(StreamInfo streamInfo, String format) async {
    try {
      setState(() {
        _isDownloading = true;
        _progress = 0.0;
      });

      var appDir = await getApplicationDocumentsDirectory();
      var fileExtension = format == 'audio' ? 'mp3' : 'mp4';
      var fileName = "${_videoTitle ?? 'Downloaded_File'}.$fileExtension";
      var filePath = '${appDir.path}/$fileName';

      var stream = _youtube.videos.streamsClient.get(streamInfo);
      var file = await File(filePath).create();
      var sink = file.openWrite();
      var color =await getImageAndGeneratePalette(_videoThumbnail ?? "");
      var total = streamInfo.size.totalBytes;
      var received = 0;
      await for (final chunk in stream) {
        received += chunk.length;
        setState(() {
          _progress = received / total;
        });
        sink.add(chunk);
      }
      await sink.close();
      try {
        await SongDB.insert(
          SongModel(
            name: filePath.fileName,
            filePath: file.path,
            status: 1,
            color: color?.value ??0,
            thumbnail: _videoThumbnail ?? "",
          ),
        );
      } on Exception catch (e) {
        logger.e(e);
      }

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Downloaded: $fileName'),
      ));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error downloading file: $e'),
      ));
    } finally {
      setState(() {
        _isDownloading = false;
      });
    }
  }

  @override
  void dispose() {
    _youtube.close();
    _urlController.dispose();
    super.dispose();
  }

  Future<Color?> getImageAndGeneratePalette(String thumbnail) async {
    try {
      Response response = await dio.get(
        thumbnail,
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

        return palette.dominantColor?.color;

        // Now you can use the palette for any UI element
      } else {
        logger.d("Failed to load image, status code: ${response.statusCode}");
      }
    } catch (e) {
      logger.e('Error: $e');
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    // logger.d('Video Thumb :${_videoThumbnail}');
    return Scaffold(
      appBar: AppBar(
        title: Text('Download Options'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _urlController,
              decoration: InputDecoration(
                labelText: 'Enter YouTube URL',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: _isFetching
                  ? null
                  : () {
                      if (_urlController.text.isNotEmpty) {
                        fetchMetadata(_urlController.text);
                      }
                    },
              child: Text('Fetch Metadata'),
            ),
            if (_isFetching) ...[
              SizedBox(height: 20),
              CircularProgressIndicator(),
            ],
            if (_videoTitle != null) ...[
              SizedBox(height: 20),
              Text(_videoTitle!,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              if (_videoThumbnail != null)
                Image.network(_videoThumbnail!, height: 150),
              SizedBox(height: 20),
              Text('Select Format:', style: TextStyle(fontSize: 16)),
              SizedBox(height: 10),
              Text('Video Formats:'),
              ..._videoFormats.map(
                (format) => RadioListTile(
                  title: Text(
                      '${format.container.name} - ${format.qualityLabel} (${format.size.totalMegaBytes.toStringAsFixed(2)} MB)'),
                  value: format,
                  groupValue: _selectedVideoFormat,
                  onChanged: (value) {
                    setState(() {
                      _selectedVideoFormat = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 10),
              Text('Audio Formats:'),
              ..._audioFormats.map(
                (format) => RadioListTile(
                  title: Text(
                      '${format.container.name} (${format.size.totalMegaBytes.toStringAsFixed(2)} MB)'),
                  value: format,
                  groupValue: _selectedAudioFormat,
                  onChanged: (value) {
                    setState(() {
                      _selectedAudioFormat = value;
                    });
                  },
                ),
              ),
              SizedBox(height: 20),
              _isDownloading
                  ? Column(
                      children: [
                        LinearProgressIndicator(value: _progress),
                        SizedBox(height: 10),
                        Text('${(_progress * 100).toStringAsFixed(0)}%'),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: () {
                        if (_selectedVideoFormat != null) {
                          downloadFile(_selectedVideoFormat!, 'video');
                        } else if (_selectedAudioFormat != null) {
                          downloadFile(_selectedAudioFormat!, 'audio');
                        }
                      },
                      child: Text('Download'),
                    ),
            ],
          ],
        ),
      ),
    );
  }
}
