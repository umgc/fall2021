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
import 'package:untitled3/Services/NLU/Bot/NLULibService.dart';
import 'package:untitled3/Services/VoiceOverTextService.dart';
import 'package:untitled3/Utility/Constant.dart';
part 'MicObservable.g.dart';

/**
 * TODO: 
 *   - Enable multi languages.
 *   - Bubble buttons are responsive.
 * 
 */
class MicObserver = _AbstractMicObserver with _$MicObserver;

abstract class _AbstractMicObserver with Store {
  late final NLULibService nluLibService;

  _AbstractMicObserver() {
    nluLibService = NLULibService();
  }

  //messageInputText will be initialize, read and added to the systemUserMessage to be displayed in the chat bubble.
  @observable
  String messageInputText = "";

  //Flag is turn on when the system expects the user to speak. And off otherwise.
  @observable
  bool micIsExpectedToListen = false;

  @observable
  bool expectingUserFollowupResponse = false;

  //Tracks the systems confidence in transcribing the users voice to text.
  @observable
  double speechConfidence = 0;

  //Holds Message interaction between the NLU and the User to be displayed in the UI.
  @observable
  ObservableList<dynamic> systemUserMessage = ObservableList();

  //Instance of MainNavObserver to be passed in from Mic.dart
  @observable
  dynamic mainNavObserver;

  //Instance of Notebservable to be passed in from Mic.dart
  @observable
  dynamic noteObserver;

  @observable
  NLUResponse? lastNluMessage;

  @observable
  FollowUpTypes? followUpTypesForMsgSent;

  //Speech library user for interfacing with the device's mic resource.
  SpeechToText _speech = SpeechToText();

  List<String> resolveVals = ["Remind me to buy eggs", "on Friday", "at 12pm"];
  int index = 0;

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
      micIsExpectedToListen = false;
      _speech.stop();
      systemUserMessage.clear();
      clearMsgTextInput();
      //Reset all values on stopping
    }
  }

  @action
  void _clearChatHistory() {
    systemUserMessage.clear();
  }

  @action
  void addUserMessage(String userMsg) {
    expectingUserFollowupResponse = false;
    print("added user message");
    systemUserMessage.add(userMsg);
  }

  @action
  void addSystemMessage(NLUResponse nluResponse) {
    if (nluResponse.resolvedValues == null)
      expectingUserFollowupResponse = false;

    systemUserMessage.add(nluResponse);
  }

  @action
  void addFollowUpMessage(
      String message, List<String> responsOptions, FollowUpTypes followupType) {
    if (expectingUserFollowupResponse == true) {
      print(
          "addFollowUpMessage: Still waiting user to respond to the previous followup message");

      //call the listener function
      //_listen(micIsExpectedToListen);
      return;
    }

    expectingUserFollowupResponse = true;

    followUpTypesForMsgSent = followupType;

    //reply with a no action followup "Ok I will not create note"
    AppMessage appMessage = AppMessage(
        message: message,
        responsOptions: responsOptions,
        followupType: followupType);
    systemUserMessage.add(appMessage);

    //call _listener to wait for user's input
    micIsExpectedToListen = true;

    _listen(micIsExpectedToListen);
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

  /*
   * 
   * fufillNLUTask: As its name implies, it recieves an NLURespons
   *  message object and process it based on its actionType
   */
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
      case ActionType.CREATE_NOTE:

        //ask user if they will like the note create for the event.
        //Pre-followup
        print(
            " case ActionType.CREATE_NOTE: expectingUserFollowupResponse $expectingUserFollowupResponse");

        if (expectingUserFollowupResponse == false) {
          //send followup message.
          print(
              "case ActionType.CREATE_NOTE: ask user if note should be created");

          addFollowUpMessage("Should I create a note?", ["yes", "no"],
              FollowUpTypes.CREATE_NOTE);
        } else {
          //recieve follow up response
          if (messageInputText.contains("yes")) {
            //create note
            _createNote(nluResponse);
            //FollowUpMessage
            //addSystemMessage("An event has been created to 'eventType' on 'eventTime'");
          }
          //else send NEE_HELP followup
          //addSystemMessage("Is there anything I can help you with?");
          //call _listen to get user input.
        }

        break;
      case ActionType.NOTFOUND:
        break;

      case ActionType.ANSWER:
        //display the text from NLU
        //and follow up with
        print("Case ActionType.ANSWER: ${nluResponse.state}");
        addSystemMessage(nluResponse);

        if (nluResponse.state == NLUState.IN_PROGRESS) {
          //get user input and send to the NLU
          //use a flag, expectingUserInput, to know when the user is expected to speak
          micIsExpectedToListen = true;
          _listen(micIsExpectedToListen);
        } else {
          print("case ActionType.ANSWER: following up");
          Timer(
              Duration(seconds: 2),
              () => addFollowUpMessage(
                  "how can I help you?", [], FollowUpTypes.NO_ACTION));

          micIsExpectedToListen = true;
          _listen(micIsExpectedToListen);
        }

        break;
    }
  }

  //internally defined actionTypes will include
  //CREATE_NOTE
  //NEED_HELP
  void processFollowups(
      dynamic userSelection, FollowUpTypes followUpType) async {
    //display the users response in the screen.
    print("processFollowups: Selection $userSelection ");
    print("processFollowups: followUpType $followUpType ");
    expectingUserFollowupResponse = false;

    switch (followUpType) {
      case FollowUpTypes.NLU_FOLLOWUP:
        //Call the NLU service with user response to process the information
        //pass response from the NLU to fufillNLUTask
        await nluLibService
            .getNLUResponse(messageInputText, "en-US")
            .then((value) => {
                  print(
                      "processFollowups: response from NLU ${(value as NLUResponse).actionType}"),
                  fufillNLUTask(value),
                });
        break;

      case FollowUpTypes.CREATE_NOTE:
        //call the create event service

        if (userSelection == 'yes') {
          //get the last message from the user.
          late NLUResponse nluCreateNote;
          for (int i = systemUserMessage.length - 1; i > 0; i--) {
            if (systemUserMessage[i] is NLUResponse) {
              nluCreateNote = systemUserMessage[i];
              print(
                  "Processing NLU message with action type ${nluCreateNote.actionType}");

              print("processFollowups(): creating note ");

              _createNote(nluCreateNote);
            }
          }
        } else {
          //reply with a no action followup "Ok I will not create note"
          //addFollowUpMessage(
          //   "Ok I will not create note", [], FollowUpTypes.NO_ACTION);

          //initiate a NEED_HELP followup: "Is there anything else I can do for you?"
          //idealy, it will be more accurate to wait for the readtime of the previous statement.
          Timer(
              Duration(seconds: 3),
              () => {
                    addFollowUpMessage("Ok I will not create note", [],
                        FollowUpTypes.NEED_HELP)
                  });
        }
        break;
      case FollowUpTypes.NEED_HELP:
        if (userSelection == 'yes') {
          print("processFollowups(): user needs more asistance ");
          //reply: "Sure! how can I help you?"
          addFollowUpMessage(
              "Sure! how can I help you?", [], FollowUpTypes.NO_ACTION);
        } else {
          //reply with "Ok thank you! Bye bye"
          addFollowUpMessage(
              "Ok thank you! Bye bye", [], FollowUpTypes.NO_ACTION);
          if (micIsExpectedToListen == true) {
            toggleListeningMode();
          }
        }
        break;

      default:
        print("Sending user selection to NLU: $userSelection");
        await nluLibService
            .getNLUResponse(userSelection, "en-US")
            .then((value) => {
                  print(
                      "_onDone: response from NLU ${(value as NLUResponse).actionType}"),
                  fufillNLUTask(value),
                });
    } //switch (followUpType)
  } //processFollowups Ends

  /*
   * Function creates and save notes.
   */
  void _createNote(NLUResponse nluResponse) {
    //get the last message from the user.

    //call the create event service
    TextNote note = TextNote();
    note.text = nluResponse.eventType!;
    note.eventDate =
        ((nluResponse.eventDate != null) ? nluResponse.eventDate : "")!;

    note.eventTime =
        ((nluResponse.eventTime != null) ? nluResponse.eventTime : "")!;
    note.isCheckList = (nluResponse.recurringType != null);
    //note.recordLocale = (nluResponse.recurringType != null);
    note.recordedTime = DateTime.now();
    (noteObserver as NoteObserver).addNote(note);

    //Note has been created.
    addSystemMessage(nluResponse);

    //FollowUpMessage
    //addSystemMessage("Is there anything I can help you with?");
  }

  /*
   * Call back function called when system is done listening.
   */
  void _onDone(status) async {
    print('_onDone: onStatus: $status');
    print('_onDone: micIsExpectedToListen $micIsExpectedToListen');

    if (status == "done") {
      print(
          '_onDone: Calling the NLU  with text : "$messageInputText  expectingUserFollowupResponse $expectingUserFollowupResponse" ');
      if (lastNluMessage == null) expectingUserFollowupResponse = false;

      //if incoming message is a voice response from a followup
      if (expectingUserFollowupResponse == true) {
        String yesNo = (messageInputText.contains("yes")) ? "yes" : "no";
        processFollowups(yesNo, followUpTypesForMsgSent!);
      } else {
        //if messageInputText is populated (user's voice was captured), call the NLU
        if (messageInputText.isNotEmpty) {
          addUserMessage(messageInputText);
          await nluLibService
              .getNLUResponse(messageInputText, "en-US")
              .then((value) => {
                    print(
                        "_onDone: response from NLU ${(value as NLUResponse).actionType}"),
                    print(
                        "_onDone: response from NLU ${(value as NLUResponse).response}"),
                    fufillNLUTask(value),
                  });
          messageInputText = "";
        }

        //Else messageInputText is empty (user's voice was NOT captured)
        // -Follow up if user needs help
        // - reiniated the listening; to get user's response.
        else {
          //if message last sent was FollowUpTypes.NO_ACTION
          if (expectingUserFollowupResponse == false) {
            addFollowUpMessage(
                "What can I help you with?", [], FollowUpTypes.NO_ACTION);
            _listen(micIsExpectedToListen);
          } else {
            _listen(micIsExpectedToListen);
          }
        }
      }
    }
  }

  /*
   * Call back function called when system experiences an error while listening.
   * When error occurs, it calls the _listen() function to re-initiate the listening mode
   * Note that this function is first call in the _listen() and by it calling _listen() results
   * to recursive calls.
   */
  void _onError(status) async {
    print('_onError: onStatus: $status');
    //Re-initiate speech service on error
    micIsExpectedToListen = false;

    await _listen(micIsExpectedToListen);
  }

  /*
   * This function initialized the speech interface and turns on listening mode 
   * It has two call back functions:
   * _onDone - called when app is done listening.
   * _onErro - called if an error occurs during the listening process. 
   * 
   */
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
          if (val.hasConfidenceRating && val.confidence > 0)
            speechConfidence = val.confidence
        },
      );
    }
  }
}

enum FollowUpTypes { CREATE_NOTE, NEED_HELP, NO_ACTION, NLU_FOLLOWUP }

class AppMessage {
  String message;
  List<String> responsOptions;
  FollowUpTypes followupType;

  AppMessage(
      {this.message = "Is there anything else I can help you with?",
      this.responsOptions = const ["Yes", "No"],
      this.followupType = FollowUpTypes.NEED_HELP});
}
