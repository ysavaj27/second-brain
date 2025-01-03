import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class DownloadScreen extends StatefulWidget {
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
  final Dio _dio = Dio();
  final YoutubeExplode _youtube = YoutubeExplode();

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

  @override
  Widget build(BuildContext context) {
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
                      _selectedVideoFormat = value ;
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
