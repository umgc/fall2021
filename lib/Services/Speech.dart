import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:highlight_text/highlight_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'dart:collection';



class Speech extends StatefulWidget {

  @override
  _SpeechState createState() => _SpeechState();
}

class _SpeechState extends State<Speech> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, HighlightedWord> _highlights = {
      'flutter': HighlightedWord(
        onTap: () => print('flutter'),
        textStyle: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.bold,
        ),
      ),
      'voice': HighlightedWord(
        onTap: () => print('voice'),
        textStyle: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
      'subscribe': HighlightedWord(
        onTap: () => print('subscribe'),
        textStyle: const TextStyle(
          color: Colors.red,
          fontWeight: FontWeight.bold,
        ),
      ),
      'like': HighlightedWord(
        onTap: () => print('like'),
        textStyle: const TextStyle(
          color: Colors.blueAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
      'comment': HighlightedWord(
        onTap: () => print('comment'),
        textStyle: const TextStyle(
          color: Colors.green,
          fontWeight: FontWeight.bold,
        ),
      ),
    };

    return Scaffold(
      backgroundColor: Color(0xFFDDD7D7),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).errorColor,
          endRadius: 75.0,
          duration: const Duration(milliseconds: 100),
          repeatPauseDuration: const Duration(milliseconds: 100),
          repeat: true,
          child: Container(
            width: 200.0,
            height: 200.0,
            child: new RawMaterialButton(
              shape: new CircleBorder(),
              elevation: 0.0,
              child: Column(children: [
                Image(
                  image: AssetImage("assets/images/mic.png"),
                  color: Color(0xFF33ACE3),
                  height: 100,
                  width: 100.82,

                ),
                Text('Press to Record',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ))
              ]),
              onPressed: _Listen,
            ),
          )),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(

          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: _text,
            words: _highlights as LinkedHashMap<String, HighlightedWord>,
            textStyle: const TextStyle(
              fontSize: 30,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _Listen() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}

// TODO Dan help taking the text and create a note then list it in the note screen.


