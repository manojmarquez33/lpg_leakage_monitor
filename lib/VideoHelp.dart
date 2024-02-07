import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        hintColor: Colors.orangeAccent,
      ),
      home: VideoListScreen(),
    );
  }
}

class VideoListScreen extends StatelessWidget {
  final List<Map<String, String>> videoList = [
    {
      'title': 'Prevent LPG Gas Leakage Accidents',
      'videoId': '2xaUOf97Rf8',
    },
    {
      'title': 'How to control LPG Gas Cylinder fire',
      'videoId': '5cVpM9XU9nA',
    },
    {
      'title': 'Cop Shows How to Stop LPG Gas Cylinder Fire',
      'videoId': 'Vni11P8IbX4',
    },
    {
      'title': 'LPG GAS FIRE SAFETY TAMIL VERSION',
      'videoId': 'u_MzGGthgpo',
    },
    {
      'title': 'Tips for safe usage of LPG',
      'videoId': 'hnluUwjpv5g',
    },
    {
      'title': 'Gas King domestic gas safety device 3D animation',
      'videoId': 'hsaqauzJKvA',
    },
    {
      'title': 'Indane LPG safety',
      'videoId': 'BwRxqE_e4cQ',
    },
    {
      'title': 'LPG precautions for consumers',
      'videoId': 'nu-fwOnjsXg',
    },
    {
      'title': 'Safety Tips While Using Gas Cylinders',
      'videoId': '_GO8wfcDTSQ',
    },
    {
      'title': 'LPG safety measures',
      'videoId': 'sZCthJWXHio',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LPG Safety Videos'),
        backgroundColor: Color(0xFF4285F4),
      ),
      body: ListView.builder(
        itemCount: videoList.length,
        itemBuilder: (context, index) {
          return VideoCard(
            title: videoList[index]['title']!,
            videoId: videoList[index]['videoId']!,
          );
        },
      ),
    );
  }
}

class VideoCard extends StatelessWidget {
  final String title;
  final String videoId;

  VideoCard({required this.title, required this.videoId});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16.0),
      elevation: 5.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => YoutubePlayerScreen(videoId: videoId),
                ),
              );
            },
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15.0),
                topRight: Radius.circular(15.0),
              ),
              child: Image.network(
                'https://img.youtube.com/vi/$videoId/mqdefault.jpg',
                height: 200.0,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.all(12.0),
            child: Text(
              title,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class YoutubePlayerScreen extends StatefulWidget {
  final String videoId;

  YoutubePlayerScreen({required this.videoId});

  @override
  _YoutubePlayerScreenState createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = YoutubePlayerController(
      initialVideoId: widget.videoId,
      flags: YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LPG Safety Video'),
      ),
      body: Center(
        child: YoutubePlayer(
          controller: _controller,
          showVideoProgressIndicator: true,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }
}
