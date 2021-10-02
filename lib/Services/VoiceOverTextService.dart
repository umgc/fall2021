import 'package:flutter_tts/flutter_tts.dart';

class VoiceOverTextService {

  VoiceOverTextService();

  static void speakOutLoud(String text) async {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.awaitSpeakCompletion(true);
    return flutterTts.speak(text);
  }
}
