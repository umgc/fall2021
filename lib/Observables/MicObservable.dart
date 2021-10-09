import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:speech_to_text/speech_to_text.dart';
//import 'package:reading_time/reading_time.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
import 'package:untitled3/Services/NLU/Bot/NLULibService.dart';
import 'package:untitled3/Services/VoiceOverTextService.dart';
part 'MicObservable.g.dart';

class MicObserver = _AbstractMicObserver with _$MicObserver;

abstract class _AbstractMicObserver with Store {
  late final NLULibService nluLibService;

  _AbstractMicObserver() {
    nluLibService = NLULibService();
  }

  //remove this.
  @observable
  int mockIndex = 0;

  //messageInputText will be initialize and read and then its content will be added to the systemUserMessage to be displayed in the chat bubble.
  @observable
  String messageInputText = "";

  @observable
  bool micIsExpectedToListen = false;

  @observable
  String micStatus = "";

  @observable
  double speechConfidence = 0;

  @observable
  ObservableList<dynamic> systemUserMessage = ObservableList();

  @observable
  NLUResponse? nluResponse;

  SpeechToText _speech = SpeechToText();

  @action
  void toggleListeningMode() {
    print("MicObserver: Starting listening mode ");
    (!micIsExpectedToListen)
        ? micIsExpectedToListen = true
        : micIsExpectedToListen = false;

    if (micIsExpectedToListen) {
      _listen(micIsExpectedToListen);
    } else {
      _speech.stop();
      if (messageInputText.isNotEmpty)
        setMessageInputText(messageInputText, false);
      clearMsgTextInput();
    }
  }

  @action
  void addUserMessage(String name) {
    print("added user message");
    systemUserMessage.add(name);
  }

  @action
  void addSystemMessage(NLUResponse name) {
    systemUserMessage.add(name);
  }

  @action
  void fufillTask(NLUResponse name) {
    //Save notes
    //Go to help screeen
    //Navigate to another screen
    //etc.
  }

  @action
  void clearMsgTextInput() {
    messageInputText = "";
  }

  @action
  void setVoiceMsgTextInput(value) {
    messageInputText = value;
  }

  @action
  Future<void> setMessageInputText(dynamic value, bool isSysrMsg) async {
    //push prev message to chartBubble
    if (isSysrMsg == true) {
      VoiceOverTextService.speakOutLoud((value as NLUResponse).response!);
      messageInputText = (value as NLUResponse).response!;
      Timer(Duration(seconds: 2), () {
        addSystemMessage((value as NLUResponse));
      });
    } else {
      print("adding a user message $value");
      messageInputText = value;
      await nluLibService
          .getNLUResponse(messageInputText, "en-US")
          .then((value) => setMessageInputText(value, true));
      Timer(Duration(seconds: 1), () {
        addUserMessage(value);
      });
    }
  }

  void _onDone(status) async {
    print('onStatus: $status');
    if (status == "notListening" && micIsExpectedToListen == true) {
      //Re-initiate speech service if user still expects it to listen
      _listen(micIsExpectedToListen);
    }
  }
  void _onError(status) async {
    print('onStatus: $status');
    //Re-initiate speech service on error
    _listen(micIsExpectedToListen);
  }

  Future<void> _listen(micIsExpectedToListen) async {
    bool available = await _speech.initialize(
      onStatus: (val) => _onDone(val),
      onError: (val) => _onError(val),
    );

    print("available $available");

    if (available) {
      _speech.listen(
        onResult: (val) => {
          setVoiceMsgTextInput( val.recognizedWords),
          //setVoiceMsgTextInput( val.finalResult),
          //val.finalResult
          if (val.hasConfidenceRating && val.confidence > 0)
            {speechConfidence = val.confidence}
        },
      );
    }
  }
}
