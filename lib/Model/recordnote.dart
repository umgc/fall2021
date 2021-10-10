import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:untitled3/Services/NoteService.dart';
import 'package:untitled3/generated/i18n.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:provider/provider.dart';
import '../../Observables/NoteObservable.dart';
import 'package:untitled3/Model/Note.dart';




final recordNoteScaffoldKey = GlobalKey<ScaffoldState>();

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final textController = TextEditingController();
  bool _getChat = false;

  bool get getChat => _getChat;

  set getChat(bool value) {
    _getChat = value;
  }

  SpeechToText _speech = SpeechToText();
  late FlutterTts flutterTts;

  bool _isListening = false;
  String _textSpeech = '';

  String get textSpeech => _textSpeech;
  String speechBubbleText =
      'Hello from Memory Magic, press the mic to start recording';
  List<Widget> actions = [];
  bool alreadyDelayed = false;

  /// Text note service to use for I/O operations against local system
  final TextNoteService textNoteService = new TextNoteService();
  Future<bool> isFirstTime() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isFirstTime = prefs.getBool('first_time') ?? true;

    if (!isFirstTime) {
      prefs.setBool('first_time', false);
      print('Not the first time here');
      return false;
    } else {
      prefs.setBool('first_time', false);
      Navigator.pushNamed(context, '/create-profile');
      return true;
    }
  }

  void onListen() async {
    if (!_isListening) {
      _textSpeech = "";

      bool available = await _speech.initialize(
        onStatus: (val) => {
          if (val == 'notListening') {print('onStatus: $val')}
        },
        onError: (val) => print('onError: $val'),
        debugLogging: true,
      );
      if (available) {
        setState(() {
          _isListening = true;
        });
        _speech.listen(
            onResult: (val) => setState(() {
                  _textSpeech = val.recognizedWords;
                }));
      }
    } else {
      setState(() {
        _isListening = false;
        _speech.stop();
        // check to see if any text was transcribed
        if (_textSpeech != '' &&
            _textSpeech != 'Press the mic button to start') {
          // if it was, then save it as a note
          setState(() {
            getChat = true;
          });
          initTts();
        }
      });
    }
  }

  void voiceHandler(Map<String, dynamic> inference) {
    if (inference['isUnderstood']) {
      if (inference['intent'] == 'startTranscription') {
        print('start recording');
        onListen();
      }
      if (inference['intent'] == 'searchNotes') {
        print('Searching notes');
        Navigator.pushNamed(context, '/view-notes');
      }
      if (inference['intent'] == 'searchDetails') {
        print('Searching for personal detail');
        Navigator.pushNamed(context, '/view-details');
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: const Text('Sorry, I did not understand'),
          backgroundColor: Colors.deepOrange,
          duration: const Duration(seconds: 1)));
    }
  }

  @override
  void initState() {
    super.initState();
    _isListening = false;
    _speech = SpeechToText();
    initTts();
  }
  initTts() async {
    flutterTts = FlutterTts();

    await flutterTts.awaitSpeakCompletion(true);
    await _speak();
  }
  Future<void> _speak() async {
    await flutterTts.speak(speechBubbleText);
  }

  @override
  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context);



    isFirstTime();

    return Scaffold(
      key: recordNoteScaffoldKey,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
          animate: _isListening,
          glowColor: Theme.of(context).primaryColor,
          endRadius: 80,
          duration: Duration(milliseconds: 2000),
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
                Text(I18n.of(context)!.notesScreenName,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ))
              ]),
              onPressed: onListen,
            ),
          )),
      body: Column(children: <Widget>[
        SingleChildScrollView(
          reverse: true,
          child: Container(
              padding: EdgeInsets.fromLTRB(30, 30, 30, 25),
              child: Text(
                _textSpeech,
                style: TextStyle(
                    fontSize: 32,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              )),
        ),

        if (getChat)

          SingleChildScrollView(
            child: Column(children: [
              Column(
                children: [
                  BubbleSpecialOne(
                    text: speechBubbleText =
                    'Would you like to save your note?',
                    isSender: false,
                    color: Color(0xAF52FF8C),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 40, right: 20.0),
                        child: ButtonTheme(
                          buttonColor: Colors.white,
                          minWidth: 100.0,
                          height: 20,
                          child: ElevatedButton(
                            onPressed: () {
                                if(textSpeech.length > 0) {
                                TextNote note = TextNote();
                                note.text = textSpeech.toString();
                                noteObserver.addNote(note);
                                noteObserver.changeScreen(
                                    I18n.of(context)!.notesScreenName);
                              }
                            },
                            child: Text("yes"),
                          ),
                        ),
                      ),
                      Container(
                        child: ButtonTheme(
                          buttonColor: Colors.white,
                          minWidth: 100.0,
                          height: 20,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                noteObserver.changeScreen(
                                    I18n.of(context)!.notesScreenName);
                              });
                            },
                            child: Text("No"),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ]),
          ),
        /*
        if(GetNote)
          SingleChildScrollView(
            child: Column(children: [
    Column(
    children: [
    BubbleSpecialOne(
    text: speechBubbleText =
    'Would you like to save your note?',
    isSender: false,
    color: Color(0xAF52FF8C),
    ),
              Column(
                children: [
                  BubbleSpecialOne(
                    text: speechBubbleText =
                    'Would you like to save your note?',
                    isSender: false,
                    color: Color(0xAF52FF8C),
                  ),
                  Row(
                    children: [
                      Container(
                        margin: const EdgeInsets.only(left: 40, right: 20.0),
                        child: ButtonTheme(
                          buttonColor: Colors.white,
                          minWidth: 100.0,
                          height: 20,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                getChat = true;
                              });
                            },
                            child: Text("No"),
                          ),
                        ),
                      ),
                      Container(
                        child: ButtonTheme(
                          buttonColor: Colors.white,
                          minWidth: 100.0,
                          height: 20,
                          child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                getChat = true;
                              });
                            },
                            child: Text("No"),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ]),
          ),*/

      ])
    );
  }

  /// Show a dialog message confirming note was saved
  showConfirmDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pushNamed(context, '/view-notes');
      },
    );

    // set up the dialog
    AlertDialog alert = AlertDialog(
      content: Text("The text note was saved successfully."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
