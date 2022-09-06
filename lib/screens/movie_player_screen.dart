import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_app_ui/components/custom_back_button.dart';
import 'package:flutter_movie_app_ui/models/movie.dart';
import 'package:video_player/video_player.dart';

class MoviePlayer extends StatefulWidget {
  const MoviePlayer({super.key, required this.movie});

  final Movie movie;

  @override
  State<MoviePlayer> createState() => _MoviePlayerState();
}

class _MoviePlayerState extends State<MoviePlayer> {
  late VideoPlayerController videoPlayerController;
  late ChewieController chewieController;

  @override
  void initState() {
    videoPlayerController = VideoPlayerController.asset(widget.movie.videoPath)
      ..initialize().then((value) {
        setState(() {});
      });
    chewieController = ChewieController(
        videoPlayerController: videoPlayerController, aspectRatio: 16 / 9);

    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SafeArea(
        child: Stack(
          children: [
            Chewie(
              controller: chewieController,
            ),
            const Positioned(
              left: 10,
              top: 10,
              child: CustomBackButton(),
            ),
          ],
        ),
      ),
    );
  }
}
