import 'package:flutter/material.dart';
import 'package:untitled3/Services/VoiceOverTextService.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';
import 'package:untitled3/Utility/Video_Player.dart';
import 'package:untitled3/generated/i18n.dart';

class WalkthroughScreen extends StatefulWidget {
  @override
  _WalkthroughScreenState createState() => _WalkthroughScreenState();
}

class _WalkthroughScreenState extends State<WalkthroughScreen> {
  var language = (I18n.locale?.countryCode != null &&
          I18n.locale?.languageCode != null)
      ? I18n.locale
      // its simply not supported unless it has a language code and a country code
      : Locale("en", "US");

  @override
  Widget build(BuildContext context) {
    VoiceOverTextService.speakOutLoud(I18n.of(context)!.walkthroughVideoLine,
        (language as Locale).languageCode.toString());

    return Scaffold(
        body: Column(children: [
      Container(
        padding: EdgeInsets.fromLTRB(15, 20, 20, 40),
        child: Text(
          I18n.of(context)!.walkthroughVideoLine,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      Expanded(
          child: Container(
              width: 750,
              height: 615,
              child: Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 50),
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
                  ))))
    ]));
  }
}
//https://pub.dev/packages/showcaseview/example