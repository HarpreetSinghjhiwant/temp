import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class SimpleVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const SimpleVideoPlayer({Key? key, required this.videoUrl}) : super(key: key);

  @override
  _SimpleVideoPlayerState createState() => _SimpleVideoPlayerState();
}

class _SimpleVideoPlayerState extends State<SimpleVideoPlayer> {
  late VideoPlayerController _controller;
  bool _hasError = false;
  bool _showControls = true;
  bool _isPlaying = false;  // Add this to track playing state

  @override
  void initState() {
    super.initState();
    _initializePlayer();
  }

  Future<void> _initializePlayer() async {
    try {
      _controller = widget.videoUrl.startsWith('http')
          ? VideoPlayerController.network(widget.videoUrl)
          : VideoPlayerController.asset(widget.videoUrl);

      await _controller.initialize();
      
      _controller.addListener(() {
        final isPlaying = _controller.value.isPlaying;
        if (isPlaying != _isPlaying) {
          setState(() {
            _isPlaying = isPlaying;
          });
        }
      });
      
      setState(() {
        _hasError = false;
      });
    } catch (e) {
      print('Error initializing video: $e');
      setState(() {
        _hasError = true;
      });
    }
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
        _showControls = true;
      } else {
        _controller.play();
        _startHideTimer();
      }
    });
  }

  void _startHideTimer() {
    Future.delayed(Duration(seconds: 2), () {
      if (mounted && _controller.value.isPlaying) {
        setState(() {
          _showControls = false;
        });
      }
    });
  }

  void _toggleControls() {
    setState(() {
      _showControls = !_showControls;
      if (_controller.value.isPlaying && _showControls) {
        _startHideTimer();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_hasError || _controller.value.hasError) {
      return Center(
        child: Text(
          'Error loading video',
          style: TextStyle(color: Colors.red, fontSize: 16),
        ),
      );
    }

    if (!_controller.value.isInitialized) {
      return Center(child: CircularProgressIndicator());
    }

    return AspectRatio(
      aspectRatio: _controller.value.aspectRatio,
      child: GestureDetector(
        onTap: _toggleControls,
        behavior: HitTestBehavior.translucent,  // Changed to translucent
        child: Stack(
          alignment: Alignment.center,
          children: [
            VideoPlayer(_controller),
            AnimatedOpacity(
              opacity: _showControls ? 1.0 : 0.0,
              duration: Duration(milliseconds: 300),
              child: GestureDetector(
                onTap: _togglePlayPause,
                child: Container(
                  color: Colors.transparent,
                  child: _PlayPauseButton(
                    controller: _controller,
                    onTap: _togglePlayPause,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class _PlayPauseButton extends StatelessWidget {
  final VideoPlayerController controller;
  final VoidCallback onTap;

  const _PlayPauseButton({required this.controller, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<VideoPlayerValue>(
      valueListenable: controller,
      builder: (context, value, child) {
        return GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              value.isPlaying ? Icons.pause : Icons.play_arrow,
              size: 48,
              color: Color(0xff605F5F),
            ),
          ),
        );
      },
    );
  }
}
