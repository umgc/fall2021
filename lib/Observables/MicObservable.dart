import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:speech_to_text/speech_to_text.dart';
//import 'package:reading_time/reading_time.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
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

  @observable
  late MainNavObserver mainNavObserver;

  @observable
  late NoteObserver noteObserver;

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
  void addUserMessage(String userMsg) {
    print("added user message");
    systemUserMessage.add(userMsg);
  }

  @action
  void addSystemMessage(NLUResponse nluResponse) {
    systemUserMessage.add(nluResponse);
  }

  @action
  void setMainNavObserver(MainNavObserver observer) {
    mainNavObserver = observer;
  }

  @action
  void setNoteObserver(NoteObserver observer) {
    noteObserver = observer;
  }

  @action
  void fufillNLUTask(NLUResponse nluResponse) {

    switch (nluResponse.actionType) {
      case ActionType.CREATE_NOTE:
        //create note
        break;

      //we probably don't need this
      case ActionType.CREATE_EVENT:
        /**
           * Ask user for more information:
           *  -Display NLU response on the screen 
           *  -Inform the user not has been created.
           *  -Inquire if they need more help
           */
        //call the create event service
        addSystemMessage(nluResponse);
        break;
      //we do not need a create note and a create event
      case ActionType.CREATE_NOTE:
        //create note
        break;

      //we probably don't need this
      case ActionType.CREATE_EVENT:
        /**
           * Ask user for more information:
           *  -Display NLU response on the screen 
           *  -Inform the user not has been created.
           *  -Inquire if they need more help
           */
        //call the create event service
        addSystemMessage(nluResponse);

        break;

      case ActionType.COMPLETE:
        //close out convirsation
        break;

      case ActionType.INCOMPLETE:
        /**
           * Ask user for more information:
           *  -display NLU response on the screen 
           *  -Turn on listening mode on the mic 
           *    to recieve voice input form user
           */
        break;

      case ActionType.NOTFOUND:
        break;

      case ActionType.ANSWER:
        //display the text from NLU
        //and follow up with
        break;
    }
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
          setVoiceMsgTextInput(val.recognizedWords),
          //setVoiceMsgTextInput( val.finalResult),
          //val.finalResult
          if (val.hasConfidenceRating && val.confidence > 0)
            {speechConfidence = val.confidence}
        },
      );
    }
  }
}
