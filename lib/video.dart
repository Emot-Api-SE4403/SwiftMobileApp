import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:video_player/video_player.dart';
import '/SoalDynamic.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class VideoPage extends StatefulWidget {
  VideoPage({Key? key, required this.id }) : super(key: key);

  int id;

  @override
  _VideoPageState createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    try {
      FlutterSecureStorage storage = const FlutterSecureStorage();
      final response = await http.get(
        Uri.parse("${dotenv.get("API_URL")}/video/download?videoid=${widget.id}"),
        headers: {
          'Authorization': "Bearer ${await storage.read(key: "jwt")}"
        },
      );

      if (response.statusCode != 200) {
        throw Exception(response.body);
      }

      data = json.decode(response.body);

      _controller = VideoPlayerController.network(
        data['download_link'],
      );
      _initializeVideoPlayerFuture = _controller.initialize();

      _controller.addListener(() {
        if (_controller.value.isInitialized) {
          print('Video sudah diinisialisasi!');
        }
      });

      setState(() {});
    } catch (exc) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text('Unknown exception: $exc'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Kembali"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.black,
              ),
              child: FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return GestureDetector(
                      onTap: () {
                        _controller.value.isPlaying
                            ? _controller.pause()
                            : _controller.play();
                      },
                      child: VideoPlayer(_controller),
                    );
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '${data['metadata']['judul']}',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Di upload pada   :${data['metadata']['time_created']}',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ),
          Expanded(child: Container()),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SoalDynamic(id_video: data['metadata']['id'], id_tugas: data['metadata']['id_tugas'],)),
                );
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                primary: Colors.red,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('KUIS'),
            ),
          ),
          const SizedBox(height: 10,)
        ],
      ),
    );
  }
}
