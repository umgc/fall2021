import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:untitled3/Model/LexResponse.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
import 'package:untitled3/Observables/MicObservable.dart';
import 'package:untitled3/Screens/Mic/ChatBubble.dart';
import 'package:untitled3/Services/NoteService.dart';
import 'package:untitled3/generated/i18n.dart';
import 'package:flutter_tts/flutter_tts.dart';


final recordNoteScaffoldKey = GlobalKey<ScaffoldState>();

class SpeechScreen extends StatefulWidget {
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  
  final textController = TextEditingController();

  SpeechToText _speech = SpeechToText();

  //late FlutterTts flutterTts;

  //bool _isListening = false;
  //String _textSpeech = '';

  //String get textSpeech => _textSpeech;

  String speechBubbleText =
      'Press the mic to speak';

  //List<Widget> actions = [];

  //bool alreadyDelayed = false;

  /// Text note service to use for I/O operations against local system
  final TextNoteService textNoteService = new TextNoteService();

  void onListen(MicObserver micObserver ) async {
    late String speechToText; 
      print("Initializing mic");
    if(!micObserver.micIsListening){
      
      bool available = await _speech.initialize(
        onStatus: (val) => {
          if (val == 'notListening') {print('onStatus: $val')}
        },
        onError: (val) => {
          print('onError: $val'),
          micObserver.stopListening()
        },
        debugLogging: true,
      );
     
     print("Done Initializing. mic status: $available");
      if (available) {
          micObserver.startListening();
         _speech.listen(
            onResult: (val) => setState(() {

                  //activate listening mode
                  speechToText = val.recognizedWords;
                  // if(speechToText.contains("hello magic") && !micObserver.micIsListening){
                  //     micObserver.startListening();
                  // }

                  // //deactivate listening mode
                  // if(speechToText.contains("bye magic") && micObserver.micIsListening){
                  //     micObserver.stopListening();
                  // }
                  //magic is activated and it is listeninng and process user info
                  if(micObserver.micIsListening){
                    micObserver.setMessageInputText(speechToText, false);
                  }

            }));
      }
      }else{
        micObserver.stopListening();
      }
     
  }

  @override
  void initState() {
    super.initState();
    _speech = SpeechToText();
    
  }

  // initTts() async {
  //   flutterTts = FlutterTts();
  //   await flutterTts.awaitSpeakCompletion(true);
  //   await _speak();
  // }

  // Future<void> _speak() async {
  //   await flutterTts.speak(speechBubbleText);
  // }

  @override
  Widget build(BuildContext context) {
    
    final micObserver = Provider.of<MicObserver>(context);
    ScrollController _controller = new ScrollController();
    //onListen(micObserver);

    return Observer(
              builder: (_) => 
      Scaffold(
      key: recordNoteScaffoldKey,
      
      body: Column(children: <Widget>[
         Container(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
              child: Text( 
                micObserver.messageInputText,
                style: TextStyle(
                    fontSize: 24,
                    color: Colors.black,
                    fontWeight: FontWeight.w500)),
            ),
        
        //if (getChat)
         Expanded ( 
           child:ListView.builder(
            shrinkWrap: true,
            physics: const AlwaysScrollableScrollPhysics(),
            controller: _controller,
            itemCount: micObserver.systemUserMessage.length,
            itemBuilder: (BuildContext context, int index){
                dynamic chatObj =  micObserver.systemUserMessage[index];
                //Display text at the top before moving it to the chat bubble
                if(chatObj is String){
                  
                 return ChatMsgBubble(message:chatObj.toString(), isSender: true );
                }
                NLUResponse nluResponse =  (chatObj as NLUResponse);

                //NLU will send question with options of responses to chose from.
                if(nluResponse.actionType ==ActionType.ANSWER){
                    return ChatMsgBubble(message:nluResponse.response, hasAction: true);
                }

                return ChatMsgBubble(message:nluResponse.response);
            }
           )
          ),
        
      ])
    ));
  }

  
}
