import 'dart:async';

import 'package:mobx/mobx.dart';
import 'package:speech_to_text/speech_to_text.dart';
//import 'package:reading_time/reading_time.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
import 'package:untitled3/Model/NLUState.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';
import 'package:untitled3/Screens/Note/NoteDetail.dart';
import 'package:untitled3/Services/NLU/Bot/NLULibService.dart';
import 'package:untitled3/Services/VoiceOverTextService.dart';
import 'package:untitled3/Utility/Constant.dart';
part 'MicObservable.g.dart';

class MicObserver = _AbstractMicObserver with _$MicObserver;

abstract class _AbstractMicObserver with Store {
  late final NLULibService nluLibService;

  _AbstractMicObserver() {
    nluLibService = NLULibService();
  }

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
  dynamic mainNavObserver;

  @observable
  dynamic noteObserver;

  SpeechToText _speech = SpeechToText();

  List<String> resolveVals = ["are going to", "am going to", "is going to"];
  List<NLUResponse> testData = [

    NLUResponse(ActionType.ANSWER, "John and Sally are going to buy me clothes",
                 "On what date are John and Sally going to buy you clothes?", NLUState.IN_PROGRESS, "", null, ["are going to", "am going to", "is going to"], null, null),

    NLUResponse(ActionType.CREATE_EVENT, "4 in the afternoon", "John and Sally are going to buy me clothes", NLUState.COMPLETE, "buy me clothes", DateTime.now(), null, null, null),
    NLUResponse(ActionType.APP_NAV, "Go to notes screen", "notes", NLUState.COMPLETE, null, null, null, null, null),
    NLUResponse(ActionType.APP_HELP, "Go to menu screen", "menu", NLUState.COMPLETE, null, null, ["Create Note", "Settng"], null, null)
    
  ];
  

  @action
  void toggleListeningMode() {

     /**
     * User activates mic's listening mode
     *  -micIsExpectedToListen = true;
     * Call listen()
     *  -Begin idle time count down (reset time each time the user speaks) 
     *  -Gets user voice input stream 
     *  -Stop listening 
     *      * on mic button click [x]
     *      * on timeout [x]
     *      * on sleep word []
     *  -update the UI message diplay.
     *  -Send message collected to the NLU []
     *  -Recieve NLU Response and call fulfill response 
     */
    print("MicObserver: Starting listening mode ");
    (!micIsExpectedToListen)
        ? micIsExpectedToListen = true
        : micIsExpectedToListen = false;

    print("toggleListeningMode: micIsExpectedToListen  $micIsExpectedToListen");

    if (micIsExpectedToListen) {
      _listen(micIsExpectedToListen);
    } else {
      _speech.stop();
      systemUserMessage.clear();
      clearMsgTextInput();
    }
  }

  @action
  void _clearChatHistory(){
      systemUserMessage.clear();
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
  void setNoteObserver(observer) {
    noteObserver = observer;
  }

  @action
  void setMainNavObserver(observer) {
    mainNavObserver = observer;
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
  void fufillNLUTask(NLUResponse nluResponse) {

    //final noteObserver = Provider.of<NoteObserver>(context); 
    print("Processing NLU message with action type ${nluResponse.actionType}");
    MainNavObserver resolvedMainNav = (mainNavObserver as MainNavObserver);

    switch (nluResponse.actionType) {
      
      case ActionType.APP_NAV:

          String screenName = nluResponse.response!;
          switch (screenName) {
            case 'menu':
              resolvedMainNav.changeScreen(MAIN_SCREENS.MENU);
              break;
            case "notes":
              resolvedMainNav.changeScreen(MAIN_SCREENS.NOTE);
             break;
            case "notifications":
              resolvedMainNav.changeScreen(MAIN_SCREENS.NOTIFICATION);
             break;
            case "settings":
              resolvedMainNav.changeScreen(MENU_SCREENS.SETTING);
             break;
            case "help":
              resolvedMainNav.changeScreen(MENU_SCREENS.HELP);
             break;
            case "trigger":
              resolvedMainNav.changeScreen(MENU_SCREENS.TRIGGER);
             break;
            //case "profile":
              //resolvedMainNav.changeScreen(MENU_SCREENS.PROFILE);
            // break;
            //case "security":
            //  resolvedMainNav.changeScreen(MENU_SCREENS.SECURITY);
            // break;
            case "calendar":
              resolvedMainNav.changeScreen(MAIN_SCREENS.CALENDAR);
             break;
            case "checklist":
              resolvedMainNav.changeScreen(MAIN_SCREENS.MENU);
             break;
            
            default: //TODO ask for more info.

          }
        
        //create note
        break;

      case ActionType.USER_LOCATION:
          //get the user current location
          //inform the user.
          //Follow up if the user needs additional help
          
        break;
      case ActionType.APP_HELP:
          //Open the help instructions 
          //(mainNavObserver as MainNavObserver).changeScreen(MAIN_SCREENS.CALENDAR)
        break;

      //we probably don't need this
      case ActionType.CREATE_RECURRING_EVENT:
      case ActionType.CREATE_EVENT:
      case ActionType.CREATE_NOTE:
        /**
           * Ask user for more information:
           *  -Display NLU response on the screen 
           *  -Inform the user not has been created.
           *  -Inquire if they need more help
           */
        //call the create event service
        TextNote note = TextNote();
        note.text = nluResponse.eventType!;
        note.eventDate = nluResponse.eventTime!;
        note.isCheckList = (nluResponse.recurringType != null);
        //note.recordLocale = (nluResponse.recurringType != null);
        note.recordedTime = DateTime.now();
        print("Processing NLU message with action type ${nluResponse.actionType}");

        //note.preferredLocale will always be their current local at time when data is pulled
        print("Adding note ${nluResponse.actionType}");

        (noteObserver as NoteObserver).addNote(note);

        //FollowUpMessage
        //addSystemMessage("And event has been created to 'eventType' on 'eventTime'");

        //addSystemMessage("Is there anything I can help you with?");
        
        break;
      case ActionType.NOTFOUND:
        break;

      case ActionType.ANSWER:
        //display the text from NLU
        //and follow up with
        addSystemMessage(nluResponse);

        if(nluResponse.state == NLUState.COMPLETE){
          //FollowUpMessage
          //addSystemMessage("Is there anything I can help you with?");
        }else {
          //get user input and send to the NLU
          //use a flag, expectingUserInput, to know when the user is expected to speak
          //expectingUserInput is toggled to off when system is audible.
        }

        break;
    }
  }
 
  void _onDone(status) async {
    print('_onDone: onStatus: $status');
    print('_onDone: micIsExpectedToListen $micIsExpectedToListen');

    if (status == "notListening" && micIsExpectedToListen == true) {
      micIsExpectedToListen = false;
      //Re-initiate speech service if user still expects it to listen
      //_listen(micIsExpectedToListen);
    }
    if(status == "done"){
       print('_onDone: Calling the NLU  with text : "$messageInputText" ');
      if (messageInputText.isNotEmpty){
        await nluLibService
            .getNLUResponse(messageInputText, "en-US")
            .then((value) => {
                print("_onDone: response from NLU ${ (value as NLUResponse).response }"),
                addUserMessage(messageInputText),
                fufillNLUTask(value),
            });
      }
    }
  }

  void _onError(status) async {
    print('_onError: onStatus: $status');
    //Re-initiate speech service on error
    micIsExpectedToListen = true;

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
        //listenFor: Duration(minutes: 15),
        onResult: (val) => {
          setVoiceMsgTextInput(val.recognizedWords),
          print(val.recognizedWords),

          if (val.hasConfidenceRating && val.confidence > 0)
            {speechConfidence = val.confidence}
        },
      );
    }
  }
}
