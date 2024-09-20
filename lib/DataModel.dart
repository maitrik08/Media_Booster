import 'package:assets_audio_player/assets_audio_player.dart';

class DataModel {
  String Name = '';
  String Artist = '';
  String Image = '';
  String Song = '';
  AssetsAudioPlayer Controller = AssetsAudioPlayer();
  DataModel(
      {required this.Name,
      required this.Artist,
      required this.Image,
      required this.Song,
      required this.Controller});
}
