import 'dart:async';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:media_player/AudioDetailPage.dart';
import 'package:media_player/DataModel.dart';
import 'package:media_player/VideoData.dart';
import 'package:media_player/VideoDetailPage.dart';
import 'package:video_player/video_player.dart';

class Music extends StatefulWidget {
  const Music({super.key});

  @override
  State<Music> createState() => _MusicState();
}

class _MusicState extends State<Music> with SingleTickerProviderStateMixin {
  late TabController controller;
  List<DataModel> AudioData = [
    DataModel(
        Name: 'Chaleya',
        Artist: 'Arijit Singh',
        Image: 'Assets/Images/Chaleya.jpg',
        Song: 'Assets/Song/Chaleya.mp3',
        Controller: AssetsAudioPlayer()),
    DataModel(
        Name: 'What Jumkha?',
        Artist: 'Arijit Singh and Jonita Gandhi',
        Image: 'Assets/Images/jumkha.jpg',
        Song: 'Assets/Song/Jumkha.mp3',
        Controller: AssetsAudioPlayer()),
    DataModel(
        Name: 'Rashke qamar',
        Artist: 'Nusrat Fateh Ali Khan',
        Image: 'Assets/Images/rashke.jpg',
        Song: 'Assets/Song/Rashke.mp3',
        Controller: AssetsAudioPlayer()),
    DataModel(
        Name: 'Tum Mile',
        Artist: 'Neeraj Shridhar',
        Image: 'Assets/Images/tummile.jpg',
        Song: 'Assets/Song/Tummile.mp3',
        Controller: AssetsAudioPlayer()),
    DataModel(
        Name: 'Vhalam Avo ne',
        Artist: 'Jigardan Gadhavi',
        Image: 'Assets/Images/valam.jpg',
        Song: 'Assets/Song/Vhalam.mp3',
        Controller: AssetsAudioPlayer())
  ];
  List<VideoData> videoData = [
    VideoData(
        Name: 'Video 1',
        Controller: VideoPlayerController.asset('Assets/Video/Chaleya.mp4')),
    VideoData(
        Name: 'Video 2',
        Controller: VideoPlayerController.asset('Assets/Video/Jhumka.mp4')),
    VideoData(
        Name: 'Video 3',
        Controller: VideoPlayerController.asset('Assets/Video/Rashke.mp4')),
    VideoData(
        Name: 'Video 4',
        Controller: VideoPlayerController.asset('Assets/Video/TumMile.mp4')),
    VideoData(
        Name: 'Video 5',
        Controller: VideoPlayerController.asset('Assets/Video/Vhalam.mp4')),
  ];
  List<String> Videos = [
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ElephantsDream.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerEscapes.mp4',
    'http://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerFun.mp4',
    'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/TearsOfSteel.mp4'
  ];
  var streamController = StreamController.broadcast();
  CarouselController Controller = CarouselController();
  List<Duration> DurationList = [];
  @override
  void initState() {
    controller = TabController(vsync: this, length: 2, initialIndex: 0);
    for (int index = 0; index < videoData.length; index++) {
      videoData[index].Controller =
          VideoPlayerController.networkUrl(Uri.parse(Videos[index]))
            ..initialize().then((_) {
              setState(() {});
            });
    }
    initAudio();
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: TabBarView(
          controller: controller,
          children: [
            Column(
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    'Audio List',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
                for (int index = 0; index < AudioData.length; index++) ...[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AudioDetailPage()));
                      Controller.jumpToPage(index);
                    },
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: Image.asset(
                          AudioData[index].Image,
                          height: 50,
                          width: 50,
                          fit: BoxFit.fill,
                        ),
                      ),
                      title: Text(
                        AudioData[index].Name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      subtitle: Text(
                        AudioData[index].Artist,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.grey),
                      ),
                      trailing: Icon(
                        Icons.play_circle_outline_rounded,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(color: Colors.grey.shade700),
                  ),
                ]
              ],
            ),
            Column(
              children: [
                SizedBox(height: 30),
                Center(
                  child: Text(
                    'Video List',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        color: Colors.white),
                  ),
                ),
                for (int index = 0; index < videoData.length; index++) ...[
                  InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => VideoDetailPage()));
                      Controller.jumpToPage(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 5),
                      child: ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.asset(
                            AudioData[index].Image,
                            height: 50,
                            width: 50,
                            fit: BoxFit.fill,
                          ),
                        ),
                        title: Text(
                          videoData[index].Name,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                        trailing: Icon(
                          Icons.play_circle_outline_rounded,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Divider(color: Colors.grey.shade700),
                  ),
                ]
              ],
            ),
          ],
        ),
        bottomNavigationBar: DefaultTabController(
          initialIndex: 1,
          length: 2,
          child: TabBar(
              controller: controller,
              indicatorSize: TabBarIndicatorSize.label,
              automaticIndicatorColorAdjustment: true,
              unselectedLabelColor: Colors.grey,
              labelColor: Colors.white,
              labelPadding: EdgeInsets.zero,
              indicatorColor: Colors.white,
              labelStyle: TextStyle(color: Colors.white),
              onTap: (value) {},
              tabs: [
                Tab(
                  iconMargin: EdgeInsets.zero,
                  icon: Icon(Icons.audiotrack),
                  text: 'Audio',
                ),
                Tab(
                  iconMargin: EdgeInsets.zero,
                  icon: Icon(Icons.video_camera_back_outlined),
                  text: 'Video',
                ),
              ]),
        ));
  }

  Future<void> initAudio() async {
    for (int index = 0; index < AudioData.length; index++) {
      await AudioData[index]
          .Controller
          .open(Audio(AudioData[index].Song), autoStart: false);
      AudioData[index].Controller.current.listen((event) {
        if (event != null) {
          Duration duration = event.audio.duration;
          DurationList.add(duration);
          setState(
              () {}); // Trigger a rebuild to update your UI with the loaded audio data
        }
      });
    }
  }
}
