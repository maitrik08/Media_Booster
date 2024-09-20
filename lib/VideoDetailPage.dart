import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:media_player/VideoData.dart';
import 'package:media_player/VideoProvider.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class VideoDetailPage extends StatefulWidget {
  const VideoDetailPage({super.key});

  @override
  State<VideoDetailPage> createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage> {
  CarouselController Controller = CarouselController();
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
  @override
  void initState() {
    for (int index = 0; index < videoData.length; index++) {
      videoData[index].Controller =
          VideoPlayerController.networkUrl(Uri.parse(Videos[index]))
            ..initialize().then((_) {
              setState(() {});
            });
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    final videoProvider = Provider.of<VideoProvider>(context);
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () async {
            Navigator.pop(context);
            for (int index = 0; index < videoData.length; index++) {
              await videoData[index].Controller.pause();
            }
          },
          child: Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
        ),
        title: Text(
          'Video Player',
        ),
        titleTextStyle: TextStyle(color: Colors.white, fontSize: 18),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: CarouselSlider(
        carouselController: Controller,
        items: [
          for (int index = 0; index < videoData.length; index++) ...[
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                children: [
                  videoData[index].Controller.value.isInitialized
                      ? Container(
                          height: 400,
                          width: 400,
                          color: Colors.grey.shade600,
                          child: Padding(                            padding: const EdgeInsets.all(2),
                            child: AspectRatio(
                              aspectRatio: 0.9,
                              child: VideoPlayer(videoData[index].Controller),
                            ),
                          ),
                        )
                      : CircularProgressIndicator(
                          color: Colors.white,
                        ),
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${videoData[videoProvider.index].Name}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Icon(
                          Icons.favorite_border,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 30),
                  VideoProgressIndicator(
                    videoData[index].Controller,
                    allowScrubbing: true,
                    colors: VideoProgressColors(
                        playedColor: Colors.white,
                        bufferedColor: Colors.grey.shade500),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                          onTap: () {
                            Controller.previousPage();
                          },
                          child: Icon(
                            Icons.skip_previous,
                            color: Colors.white,
                          )),
                      InkWell(
                        onTap: () {
                          videoData[index]
                              .Controller
                              .seekTo(Duration(seconds: -10));
                        },
                        child: Image.network(
                          'https://cdn-icons-png.flaticon.com/128/12581/12581570.png',
                          color: Colors.white,
                          height: 20,
                          width: 20,
                          fit: BoxFit.fill,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          videoProvider.Playpause(
                              videoData[videoProvider.index].Controller);
                        },
                        child: Icon(
                          videoData[index].Controller.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 50,
                        ),
                      ),
                      InkWell(
                          onTap: () {
                            videoData[index]
                                .Controller
                                .seekTo(Duration(seconds: 10));
                          },
                          child: Icon(
                            Icons.fast_forward_rounded,
                            color: Colors.white,
                          )),
                      InkWell(
                          onTap: () {
                            Controller.nextPage();
                          },
                          child: Icon(
                            Icons.skip_next,
                            color: Colors.white,
                          )),
                    ],
                  )
                ],
              ),
            )
          ]
        ],
        options: CarouselOptions(
          height: double.infinity,
          viewportFraction: 0.94,
          onPageChanged: (index, reason) async {
            videoProvider.changeIndex(index);
            for (int index = 0; index < videoData.length; index++) {
              await videoData[index].Controller.pause();
            }
            // videoData[VideoProvider().index].Controller = VideoPlayerController
            //     .networkUrl(Uri.parse(Videos[videoProvider.index]))
            //   ..initialize().then((_) {
            //     setState(() {});
            //   });
          },
        ),
      ),
    );
  }
}
