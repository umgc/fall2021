import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:untitled3/Utility/Video_Player.dart';
import 'package:untitled3/generated/i18n.dart';


class WalkthroughScreen extends StatefulWidget {
  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(children: [
      Container(
        padding: EdgeInsets.fromLTRB(15, 20, 20, 40),
        child: Text(
          "Here is a link to a brief "
              "walk-through of how to use "
              "the Memory Magic App.",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Container(
          width: 500,
          height: 420,
          child: Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 250),
              child: VideosList(
                looping: true,

                videoPlayerController: VideoPlayerController.network(
                    'https://assets.mixkit.co/videos/preview/mixkit-daytime-city-traffic-aerial-view-56-large.mp4'),
                // NOTE: if you save the videos as mp4 in assets file , you can use:
                /*
                      VideosList(
                        videoPlayerController: VideoPlayerController.asset(
                            'videos/Specialist_In_Python.MP4',
                        ),
                        looping: true,
                      ),
                      */
              )))
    ]));
  }
}
