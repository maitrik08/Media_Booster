import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:blur/blur.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:media_player/AudioProvider.dart';
import 'package:media_player/DataModel.dart';
import 'package:provider/provider.dart';

class AudioDetailPage extends StatefulWidget {
  AudioDetailPage({super.key});

  @override
  State<AudioDetailPage> createState() => _AudioDetailPageState();
}

class _AudioDetailPageState extends State<AudioDetailPage> {
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
        Song: 'Assets/Song/Vh  alam.mp3',
        Controller: AssetsAudioPlayer())
  ];
  CarouselController Controller = CarouselController();
  List<Duration> DurationList = [];
  @override
  void initState() {
    for (int index = 0; index < AudioData.length; index++) {
      AudioData[index]
          .Controller
          .open(Audio(AudioData[index].Song), autoStart: false);
      AudioData[index].Controller.current.listen((event) {
        if (event != null) {
          Duration duration = event.audio.duration;
          DurationList.add(duration);
          setState(() {});
        }
      });
    }
    super.initState();
  }

  Widget build(BuildContext context) {
    final audioProvider = Provider.of<AudioProvider>(context);
    return Scaffold(
      body: CarouselSlider(
        carouselController: Controller,
        items: [
          for (int index = 0; index < AudioData.length; index++) ...[
            Stack(
              children: [
                Blur(
                    blur: 10,
                    blurColor: Colors.black,
                    child: Image.asset(
                      AudioData[index].Image,
                      height: double.infinity,
                      fit: BoxFit.fitHeight,
                    )),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.arrow_back,
                              color: Colors.white,
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                'PLAYING FROM PLAYLIST',
                                style: TextStyle(color: Colors.grey.shade100),
                              ),
                              Text(
                                'Release Radar',
                                style: TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.more_vert,
                            color: Colors.white,
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          AudioData[index].Image,
                          height: 320,
                          width: 320,
                          fit: BoxFit.fill,
                        ),
                      ),
                      SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${AudioData[index].Name}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                '${AudioData[index].Artist}',
                                style: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                          )
                        ],
                      ),
                      SizedBox(height: 30),
                      StreamBuilder<Duration>(
                        stream: AudioData[audioProvider.index]
                            .Controller
                            .currentPosition,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            Duration currentPosition = snapshot.data!;
                            return ProgressBar(
                              thumbColor: Colors.white,
                              progress: currentPosition,
                              total: DurationList[audioProvider.index],
                              buffered:
                                  currentPosition, // You might want to update this as well
                              onSeek: (value) {
                                AudioData[audioProvider.index]
                                    .Controller
                                    .seekBy(value);
                              },
                              progressBarColor: Colors.white,
                              bufferedBarColor: Colors.grey.shade400,
                              baseBarColor: Colors.grey.shade700,
                              timeLabelPadding: 10,
                              timeLabelTextStyle:
                                  TextStyle(color: Colors.white),
                            );
                          } else {
                            return CircularProgressIndicator(); // You can show a loading indicator while the position is being loaded
                          }
                        },
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
                              AudioData[index]
                                  .Controller
                                  .seekBy(Duration(seconds: -10));
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
                              audioProvider.Play_Pause();
                              audioProvider.isPlaying
                                  ? AudioData[index].Controller.play()
                                  : AudioData[index].Controller.pause();
                            },
                            child: Icon(
                              audioProvider.isPlaying
                                  ? Icons.pause
                                  : Icons.play_arrow,
                              color: Colors.white,
                              size: 50,
                            ),
                          ),
                          InkWell(
                              onTap: () {
                                AudioData[index]
                                    .Controller
                                    .seekBy(Duration(seconds: 10));
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
                ),
              ],
            )
          ]
        ],
        options: CarouselOptions(
          height: double.infinity,
          viewportFraction: 0.94,
          onPageChanged: (index, reason) async {
            for (int index = 0; index < AudioData.length; index++) {
              await AudioData[index].Controller.stop();
            }
            audioProvider.changeIndex(index);
            print(audioProvider.index);
            for (int index = 0; index < AudioData.length; index++) {
              await AudioData[index]
                  .Controller
                  .open(Audio(AudioData[index].Song), autoStart: false);
              await AudioData[index].Controller.current.listen((event) {
                if (event != null) {
                  Duration duration = event.audio.duration;
                  DurationList.add(duration);
                  setState(() {});
                }
              });
            }
          },
        ),
      ),
    );
  }
}
