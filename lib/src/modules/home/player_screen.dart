import 'dart:io';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:second_brain/src/utils/plugins/logger.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  final String filePath;

  PlayerScreen({required this.filePath});

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  late AudioPlayer _audioPlayer;
  VideoPlayerController? _videoController;
  bool _isAudio = false;
  bool _isPlaying = false;
  bool _isMuted = false;
  bool _isLooping = false;
  bool _isShuffle = false;
  double _volume = 1.0;
  double _speed = 1.0;
  double _progress = 0.0;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isAudio = widget.filePath.endsWith('.mp3');

    if (_isAudio) {
      _initializeAudioPlayer();
    } else {
      _initializeVideoPlayer();
    }
  }

  Future<void> _initializeAudioPlayer() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer.setFilePath(widget.filePath);
    _audioPlayer.playingStream.listen((isPlaying) {
      setState(() {
        _isPlaying = isPlaying;
      });
    });
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _progress = position.inMilliseconds.toDouble();
      });
    });
    setState(() {});
  }

  Future<void> _initializeVideoPlayer() async {
    logger.d("Video Path :${widget.filePath}");
    _videoController = VideoPlayerController.file(File(widget.filePath))
      ..addListener(() {
        setState(() {});
      })
      ..setLooping(_isLooping)
      ..initialize().then((_) {
        setState(() {});
      });
  }

  @override
  void dispose() {
    if (_isAudio) {
      _audioPlayer.dispose();
    } else {
      _videoController?.dispose();
    }
    super.dispose();
  }

  void _togglePlayPause() {
    if (_isAudio) {
      if (_audioPlayer.playing) {
        _audioPlayer.pause();
      } else {
        _audioPlayer.play();
      }
    } else {
      if (_videoController!.value.isPlaying) {
        _videoController!.pause();
      } else {
        _videoController!.play();
      }
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _forward() {
    if (_isAudio) {
      _audioPlayer.seek(_audioPlayer.position + Duration(seconds: 10));
    } else {
      _videoController!
          .seekTo(_videoController!.value.position + Duration(seconds: 10));
    }
  }

  void _rewind() {
    if (_isAudio) {
      _audioPlayer.seek(_audioPlayer.position - Duration(seconds: 10));
    } else {
      _videoController!
          .seekTo(_videoController!.value.position - Duration(seconds: 10));
    }
  }

  void _toggleMute() {
    if (_isAudio) {
      _audioPlayer.setVolume(_isMuted ? _volume : 0.0);
    } else {
      _videoController!.setVolume(_isMuted ? _volume : 0.0);
    }
    setState(() {
      _isMuted = !_isMuted;
    });
  }

  void _toggleLooping() {
    if (_isAudio) {
      _audioPlayer.setLoopMode(_isLooping ? LoopMode.off : LoopMode.all);
    } else {
      _videoController!.setLooping(!_isLooping);
    }
    setState(() {
      _isLooping = !_isLooping;
    });
  }

  void _toggleShuffle() {
    setState(() {
      _isShuffle = !_isShuffle;
    });
  }

  void _changeSpeed(double value) {
    setState(() {
      _speed = value;
    });
    if (_isAudio) {
      _audioPlayer.setSpeed(value);
    } else {
      _videoController!.setPlaybackSpeed(value);
    }
  }

  void _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(
          _isAudio ? 'Audio Player' : 'Video Player',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: Colors.red,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: _isAudio ? _buildAudioPlayer() : _buildVideoPlayer(),
    );
  }

  Widget _buildAudioPlayer() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.music_note, size: 100, color: Colors.blueAccent),
        SizedBox(height: 20),
        Text('Now Playing',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        SizedBox(height: 10),
        Text(
          widget.filePath.split('/').last,
          style: TextStyle(color: Colors.grey),
        ),
        SizedBox(height: 20),
        Slider(
          value: _progress,
          onChanged: (value) {
            setState(() {
              _progress = value;
            });
            _audioPlayer.seek(Duration(milliseconds: value.toInt()));
          },
          min: 0.0,
          max: _audioPlayer.duration?.inMilliseconds.toDouble() ?? 100.0,
          activeColor: Colors.blueAccent,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.replay_10),
              iconSize: 40,
              onPressed: _rewind,
              color: Colors.blueAccent,
            ),
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              iconSize: 60,
              onPressed: _togglePlayPause,
              color: Colors.blueAccent,
            ),
            IconButton(
              icon: Icon(Icons.forward_10),
              iconSize: 40,
              onPressed: _forward,
              color: Colors.blueAccent,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
              iconSize: 30,
              onPressed: _toggleMute,
              color: Colors.blueAccent,
            ),
            IconButton(
              icon: Icon(_isLooping ? Icons.loop : Icons.loop_outlined),
              iconSize: 30,
              onPressed: _toggleLooping,
              color: Colors.blueAccent,
            ),
            IconButton(
              icon: Icon(_isShuffle ? Icons.shuffle : Icons.shuffle_rounded),
              iconSize: 30,
              onPressed: _toggleShuffle,
              color: Colors.blueAccent,
            ),
          ],
        ),
        SizedBox(height: 20),
        Text(
          'Speed: ${_speed.toStringAsFixed(1)}x',
          style: TextStyle(color: Colors.grey),
        ),
        Slider(
          value: _speed,
          onChanged: _changeSpeed,
          min: 0.5,
          max: 2.0,
          activeColor: Colors.blueAccent,
        ),
      ],
    );
  }

  Widget _buildVideoPlayer() {
    return _videoController!.value.isInitialized
        ? Column(
      children: [
        AspectRatio(
          aspectRatio: _videoController!.value.aspectRatio,
          child: VideoPlayer(_videoController!),
        ),
        VideoProgressIndicator(_videoController!, allowScrubbing: true),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(Icons.replay_10),
              iconSize: 40,
              onPressed: _rewind,
              color: Colors.blueAccent,
            ),
            IconButton(
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              iconSize: 60,
              onPressed: _togglePlayPause,
              color: Colors.blueAccent,
            ),
            IconButton(
              icon: Icon(Icons.forward_10),
              iconSize: 40,
              onPressed: _forward,
              color: Colors.blueAccent,
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              icon: Icon(_isLooping ? Icons.loop : Icons.loop_outlined),
              iconSize: 30,
              onPressed: _toggleLooping,
              color: Colors.blueAccent,
            ),
            IconButton(
              icon: Icon(
                  _isShuffle ? Icons.shuffle : Icons.shuffle_rounded),
              iconSize: 30,
              onPressed: _toggleShuffle,
              color: Colors.blueAccent,
            ),
          ],
        ),
        Slider(
          value: _videoController!.value.position.inMilliseconds.toDouble(),
          onChanged: (value) {
            _videoController!
                .seekTo(Duration(milliseconds: value.toInt()));
          },
          min: 0.0,
          max: _videoController!.value.duration.inMilliseconds.toDouble(),
          activeColor: Colors.blueAccent,
        ),
      ],
    )
        : Center(child: CircularProgressIndicator());
  }
}
