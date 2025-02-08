import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerComponent extends StatefulWidget {
  final String videoUrl; // Video URL
  final String image;    // Thumbnail Image URL or Asset Path

  const VideoPlayerComponent({Key? key, required this.videoUrl, required this.image}) : super(key: key);

  @override
  _VideoPlayerComponentState createState() => _VideoPlayerComponentState();
}

class _VideoPlayerComponentState extends State<VideoPlayerComponent> {
  late VideoPlayerController _controller;
  bool _isPlaying = false;  // To manage play state

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.videoUrl)
      ..initialize().then((_) {
        setState(() {}); // Refresh UI once video is initialized
      });
  }

  @override
  void dispose() {
    _controller.dispose(); // Clean up the controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _controller.value.isInitialized
          ? Stack(
              alignment: Alignment.center,
              children: [
                AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: _isPlaying 
                      ? VideoPlayer(_controller)
                      : Image.network(
                          widget.image,
                          fit: BoxFit.cover,
                        ),
                ),
                if (!_isPlaying)
                  IconButton(
                    icon: Icon(Icons.play_circle_fill, size: 64, color: Colors.white),
                    onPressed: () {
                      setState(() {
                        _isPlaying = true;
                        _controller.play();
                      });
                    },
                  ),
                if (_isPlaying)
                  Positioned(
                    bottom: 10,
                    left: 0,
                    right: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                            size: 40,
                            color: Color(0xff605F5F),
                          ),
                          onPressed: () {
                            setState(() {
                              _controller.value.isPlaying ? _controller.pause() : _controller.play();
                            });
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.replay, size: 40),
                          onPressed: () {
                            _controller.seekTo(Duration.zero);
                            _controller.play();
                          },
                        ),
                      ],
                    ),
                  ),
              ],
            )
          : CircularProgressIndicator(color: Color(0xff4E9459)),
    );
  }
}
