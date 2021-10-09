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
  late SpeechToText _speech;
  //bool _isListening = false;
  //String _text = 'Press the button and start speaking';
  //double _confidence = 1.0;
  //bool _exitOnError = false;
  //late MicObserver micObserver;
  _SpeechScreenState();

  @override
  void initState() {
    super.initState();
    _speech = SpeechToText();
  }

  // void onDone(status) async {
  //   print('onStatus: $status');
  //   if (status == "notListening") {
  //     //print('confidence: $_confidence');
  //     //_listen(micObserver);
  //     //micObserver.addUserMessage(_text);
  //   }
  // }
  //  void onError(status) async {
  //   print('onStatus: $status');
  //   //TODO: Re-initiate speech service on error
  // }

  // Future<void> _listen(MicObserver micObserver) async {
  //   print('onStatus: ${micObserver.micIsListening}');
    
  //   if (!micObserver.micIsListening) {

  //       bool available = await _speech.initialize(
  //         onStatus: (val) => onDone(val),
  //         onError: (val) => print("Error $val"),
  //       );
  //       print("available $available");

  //       if (available) {
  //         micObserver.startListening();
  //         //setState(() => _isListening = true);
  //         _speech.listen(
  //           onResult: (val) => {
  //             micObserver.setVoiceMsgTextInput(val.recognizedWords),
  //             if (val.hasConfidenceRating && val.confidence > 0) {
  //               micObserver.speechConfidence = val.confidence
  //             }
  //           },
  //         );
  //       }
  //   } else {
  //     //setState(() => _isListening = false);
  //      micObserver.stopListening();
  //     _speech.stop();
  //     if (micObserver.messageInputText.isNotEmpty) 
  //         micObserver.setMessageInputText(micObserver.messageInputText, false);
  //     micObserver.clearMsgTextInput();
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    ScrollController _controller = new ScrollController();
    //onListen(micObserver);
    final micObserver = Provider.of<MicObserver>(context); 

    return Observer(
        builder: (_) => Scaffold(
            key: recordNoteScaffoldKey,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            floatingActionButton: AvatarGlow(
                animate: micObserver.micIsExpectedToListen,
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
                    onPressed: () => micObserver.toggleListeningMode(),
                  ),
                )),
            body: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 15),
                child: Text(micObserver.messageInputText,
                    style: TextStyle(
                        fontSize: 24,
                        color: Colors.black,
                        fontWeight: FontWeight.w500)),
              ),

              //if (getChat)
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      controller: _controller,
                      itemCount: micObserver.systemUserMessage.length,
                      itemBuilder: (BuildContext context, int index) {
                        dynamic chatObj = micObserver.systemUserMessage[index];
                        //Display text at the top before moving it to the chat bubble
                        if (chatObj is String) {
                          return ChatMsgBubble(
                              message: chatObj.toString(), isSender: true);
                        }
                        NLUResponse nluResponse = (chatObj as NLUResponse);

                        //NLU will send question with options of responses to chose from.
                        if (nluResponse.actionType == ActionType.ANSWER) {
                          return ChatMsgBubble(
                              message: nluResponse.response, hasAction: true);
                        }

                        return ChatMsgBubble(message: nluResponse.response);
                      })),
            ])));
  }
}
