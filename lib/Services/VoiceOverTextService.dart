import 'package:flutter_tts/flutter_tts.dart';

class VoiceOverTextService {
  VoiceOverTextService();

  // TODO: Add the locale as a parameter and use
  // setLanguage feature to set locale as necessary
  static Future<dynamic> speakOutLoud(String text) async {
    FlutterTts flutterTts = FlutterTts();
    flutterTts.awaitSpeakCompletion(true);
    return flutterTts.speak(text);
  }
}
