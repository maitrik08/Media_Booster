import 'package:flutter/material.dart';

class  AudioProvider extends ChangeNotifier{
  int index = 0;
  bool isPlaying = false;
  void changeIndex(value){
    index = value;
    notifyListeners();
  }
  void Play_Pause(){
    isPlaying = !isPlaying;
    notifyListeners();
  }
}