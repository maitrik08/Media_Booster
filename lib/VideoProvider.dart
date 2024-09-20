import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoProvider extends ChangeNotifier {
  int index = 0;
  void changeIndex(value) {
    index = value;
    notifyListeners();
  }

  void Playpause(VideoPlayerController Controller) {
    Controller.value.isPlaying ? Controller.pause() : Controller.play();
    notifyListeners();
  }
}
