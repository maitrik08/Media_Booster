import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:media_player/AudioProvider.dart';
import 'package:media_player/Music.dart';
import 'package:media_player/VideoProvider.dart';
import 'package:provider/provider.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<AudioProvider>(create: (_) => AudioProvider()),
        ChangeNotifierProvider<VideoProvider>(create: (_) => VideoProvider()),
      ],
      child: const MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Music(),
    );
  }
}