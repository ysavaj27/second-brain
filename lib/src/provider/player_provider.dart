import 'package:just_audio/just_audio.dart';
import 'package:second_brain/src/models/song/song_model.dart';
import 'package:second_brain/src/utils/app_exports.dart';

class PlayerProver extends ChangeNotifier {
  SongModel song = SongModel();

  AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  bool _isRepeatEnabled = true;
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  bool get isPlaying => _isPlaying;

  bool get isRepeatEnabled => _isRepeatEnabled;

  Duration get currentPosition => _currentPosition;

  AudioPlayer get audioPlayer => _audioPlayer;

  Duration get totalDuration => _totalDuration;

  Future<void> initializeAudioPlayer(SongModel model) async {
    song = model;
    await _audioPlayer.setFilePath(song.filePath);
    _audioPlayer.play();
    _totalDuration = _audioPlayer.duration ?? Duration.zero;

    _audioPlayer.playingStream.listen((isPlaying) {
      _isPlaying = isPlaying;
      notifyListeners();
    });
    _audioPlayer.positionStream.listen((position) {
      _currentPosition = position;
      notifyListeners();
    });

    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        if (_isRepeatEnabled) {
          _audioPlayer.seek(Duration.zero);
          _audioPlayer.play();
        }
      }
    });
  }

  void togglePlayPause() {
    if (_audioPlayer.playing) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    _isPlaying = !_isPlaying;
    notifyListeners();
  }

  void toggleRepeat() {
    _isRepeatEnabled = !_isRepeatEnabled;
    notifyListeners();
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }
}
