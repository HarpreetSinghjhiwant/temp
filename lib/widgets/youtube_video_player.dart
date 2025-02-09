import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class VideoReviewCard extends StatefulWidget {
  final String image;
  final String videoUrl;

  const VideoReviewCard({
    Key? key,
    required this.image,
    required this.videoUrl,
  }) : super(key: key);

  @override
  _VideoReviewCardState createState() => _VideoReviewCardState();
}

class _VideoReviewCardState extends State<VideoReviewCard> {
  YoutubePlayerController? _controller;
  bool _isPlaying = false;

  void _initializePlayer() {
    final String videoId = YoutubePlayerController.convertUrlToId(widget.videoUrl) ?? '';

    if (videoId.isEmpty) {
      print('Invalid YouTube URL or Video ID not found.');
      return;
    }

    _controller = YoutubePlayerController(
      params: YoutubePlayerParams(
        showFullscreenButton: false,
        enableCaption: false,
        showControls: false,
      ),
    );

    _controller!.loadVideoById(videoId: videoId);
  }

  @override
  void dispose() {
    _controller?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Container(
        width: 247,
        height: 398,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.grey[500]!,
              spreadRadius: 4,
              blurRadius: 2
            )
          ]
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            alignment: Alignment.center,
            children: [
              if (_isPlaying && _controller != null)
                YoutubePlayer(
                  controller: _controller!,
                  aspectRatio: 9 / 16,
                ),
              if (!_isPlaying)
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isPlaying = true;
                      _initializePlayer();
                    });
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Image.asset(
                        widget.image,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          print('Error loading image: $error');
                          return Center(child: Icon(Icons.broken_image, size: 64));
                        },
                      ),
                      const Icon(
                        Icons.play_circle_fill,
                        size: 64,
                        color: Colors.white70,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
