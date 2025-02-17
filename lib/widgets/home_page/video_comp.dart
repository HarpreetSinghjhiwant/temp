import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SimpleVideoPlayer extends StatefulWidget {
  final String videoUrl;
  final String image;

  const SimpleVideoPlayer({Key? key, required this.videoUrl, required this.image}) : super(key: key);

  @override
  _SimpleVideoPlayerState createState() => _SimpleVideoPlayerState();
}

class _SimpleVideoPlayerState extends State<SimpleVideoPlayer> {
  VideoPlayerController? _controller;
  bool _hasError = false;
  bool _isInitialized = false;
  bool _isPlaying = false;
  bool _showThumbnail = true; // Initially, show the thumbnail

  Future<void> _initializePlayer() async {
    try {
      _controller = widget.videoUrl.startsWith('http')
          ? VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl))
          : VideoPlayerController.asset(widget.videoUrl);

      await _controller!.initialize();

      _controller!.addListener(() {
        if (_controller!.value.isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = _controller!.value.isPlaying;
          });
        }
      });

      setState(() {
        _isInitialized = true;
        _showThumbnail = false; // Hide the thumbnail once the video starts
      });

      _controller!.play();
    } catch (e) {
      print('Error initializing video: $e');
      setState(() {
        _hasError = true;
      });
    }
  }

  void _togglePlayPause() {
    if (_controller == null) {
      _initializePlayer();
    } else if (_controller!.value.isPlaying) {
      _controller!.pause();
    } else {
      _controller!.play();
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError) {
      return Center(
        child: Text(
          'Error loading video',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    return AspectRatio(
      aspectRatio: _isInitialized ? _controller!.value.aspectRatio : 16 / 9,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Show the video only if it's initialized
          if (_isInitialized) VideoPlayer(_controller!),

          // Show the thumbnail until the user presses it
          if (_showThumbnail)
            GestureDetector(
              onTap: _initializePlayer,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.network(widget.image, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(12),
                child: Icon(
                  _isPlaying ? Icons.pause : Icons.play_arrow,
                  size: 48,
                  color: Color(0xff605F5F),
                ),
              ),
                ],
              ),
            ),

          // Play/Pause button overlay
          if (_isInitialized)
            Positioned(
              child: GestureDetector(
                onTap: _togglePlayPause,
                child: AnimatedOpacity(
                  opacity: _isPlaying ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 300),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    padding: EdgeInsets.all(12),
                    child: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      size: 48,
                      color: Color(0xff605F5F),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }
}
