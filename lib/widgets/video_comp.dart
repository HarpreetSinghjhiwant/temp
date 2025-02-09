import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SimpleVideoPlayer extends StatefulWidget {
  final String videoUrl; // Can be a network URL or asset path

  const SimpleVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _SimpleVideoPlayerState createState() => _SimpleVideoPlayerState();
}

class _SimpleVideoPlayerState extends State<SimpleVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;
  bool _isInitialized = false;
  bool _hasError = false;

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      // Determine whether it's a network or asset video
      _controller = widget.videoUrl.startsWith('http')
          ? VideoPlayerController.network(widget.videoUrl)
          : VideoPlayerController.asset(widget.videoUrl);

      // Attempt to initialize the video player
      await _controller.initialize();
      setState(() {
        _isInitialized = true;
        _hasError = false;
      });

      // Listen for play, pause, and buffering events
      _controller.addListener(() {
        final value = _controller.value;
        setState(() {
          _isPlaying = value.isPlaying;
          if (value.isBuffering) {
            print('Video is buffering...');
          }
        });
      });
    } catch (e) {
      print('Error initializing video: $e');
      setState(() {
        _isInitialized = false;
        _hasError = true;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isInitialized) {
      return AspectRatio(
        aspectRatio: _controller.value.aspectRatio,
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(_controller),
            GestureDetector(
              onTap: _togglePlayPause,
              child: Container(
                padding: EdgeInsets.all(
                    8), // Adds space between icon and container edge
                decoration: BoxDecoration(
                  color: Colors.white, // White background
                  shape: BoxShape.circle, // Circular shape
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  _isPlaying
                      ? Icons.pause
                      : Icons
                          .play_arrow, // Simple icons without built-in background
                  size: 48, // Adjust size as needed
                  color: Colors.black, // Black inner icon
                ),
              ),


            ),
          ],
        ),
      );
    } else if (_hasError || _controller.value.hasError) {
      return Center(child: Text('Error loading video', style: TextStyle(color: Colors.red, fontSize: 16)));
    } else {
      return Center(child: CircularProgressIndicator());
    }
  }
}
