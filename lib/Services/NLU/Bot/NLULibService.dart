import 'package:untitled3/Model/LexResponse.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
import 'package:untitled3/Model/NLUState.dart';
import 'LexService.dart';
import 'package:untitled3/Model/Note.dart';
import '../../NoteService.dart';
import '../BertQA/BertQaService.dart';

  class NLULibService {

    late final BertQAService bertQAService;
    late final LexService lexService;
    static const String FallbackResponse = "Sorry not able to understand.";
    static const String AppHelp = "AppHelp";
    static const String AppNav = "AppNav";
    static const String SearchNotes = "SearchNotes";
    static const String CreateNote = "CreateNote";
    static const String CreateEvent = "MakeAppointment";
    static const String InterpretationsJsonStr = "interpretations";
    static const String DefaultLocale = "en-US";
    String previousSessionId = "";

    NLULibService() {
      lexService = LexService();
      bertQAService = BertQAService();
    }

    Future<String> getNLUResponseUITest(String text) async {
      NLUResponse nluResponse = (await getNLUResponse(text, DefaultLocale));
      String response = nluResponse.toJson().toString();
      print(response);
      return response;
    }

    Future<NLUResponse> getNLUResponse(String inputText, String locale) async {
      NLUResponse? nluResponse;
      String sessionId = getSessionId();
      Map<String, dynamic> lexResponse = await lexService.getLexResponse(
          text: inputText, userId: sessionId, locale: locale);
      if (lexResponse[InterpretationsJsonStr] != null) {
        var lexResponseObj = LexResponse.fromJson(lexResponse);
        if (lexResponseObj != null) {
          String intentName = getIntentName(lexResponseObj);
          String currentState = getState(lexResponseObj);
          Slots? currentSlots = getSlots(lexResponseObj);
          String outputText = getMessage(lexResponseObj);
          if (intentName.isNotEmpty) {
            if (intentName.startsWith(AppHelp)) {
              nluResponse = getAppHelpResponse(lexResponseObj, currentState,
                  inputText, outputText);
            } else if (intentName.startsWith(AppNav)) {
              nluResponse = getAppNavResponse(lexResponseObj, currentState,
                  inputText, outputText);
            } else if (intentName == CreateNote) {
              nluResponse = getCreateNoteResponse(lexResponseObj, currentState,
                  inputText, outputText);
            } else if (intentName == CreateEvent) {
              nluResponse = getCreateEventResponse(lexResponseObj,
                  currentState, inputText, outputText, currentSlots);
            } else if (intentName == SearchNotes) {
              nluResponse = (await getSearchNoteResponse(
                  lexResponseObj, currentState, inputText));
            }
          }
        }
      }
      if (nluResponse == null) {
        nluResponse = getFallBackResponse(inputText);
      }
      if (nluResponse.state == NLUState.INPROGRESS) {
        previousSessionId = sessionId;
      } else {
        previousSessionId = "";
      }
      return nluResponse;
    }

    /*
     * Generate new Session if the Previous session is not set.
     */
    String getSessionId() {
      String sessionId = "";
      if (previousSessionId.isEmpty)
        sessionId = TextNoteService.generateUUID();
      else
        sessionId = previousSessionId;
      return sessionId;
    }

    String getIntentName(LexResponse lexResponseObj) {
      double highestScore = 0;
      String intentName = "";
      Interpretations? selectedInterpretations = null;
      if (lexResponseObj != null) {
        if (lexResponseObj.sessionState != null
            && lexResponseObj.sessionState.intent != null
            && lexResponseObj.sessionState.intent.name.isNotEmpty) {
          intentName = lexResponseObj.sessionState.intent.name;
        } else {
          for (int i = 0; i < lexResponseObj.interpretations.length; i++) {
            Interpretations interpretations = lexResponseObj.interpretations
                .elementAt(i);
            if (interpretations != null
                && interpretations.intent != null
                && interpretations.nluConfidence != null
                && interpretations.nluConfidence.score > 0) {
              if (interpretations.nluConfidence.score > highestScore) {
                highestScore = interpretations.nluConfidence.score;
                selectedInterpretations = interpretations;
              }
            }
          }
          if (selectedInterpretations != null) {
            intentName = selectedInterpretations.intent.name;
          }
        }
      }
      return intentName;
    }

    String getMessage(LexResponse lexResponseObj) {
      String outputText = "";
      try {
        if (lexResponseObj != null
            && lexResponseObj.messages != null
            && lexResponseObj.messages.length > 0) {
          for (int i = 0; i < lexResponseObj.messages.length; i++) {
            Messages messages = lexResponseObj.messages.elementAt(i);
            if (messages != null && messages.content.isNotEmpty) {
              outputText = messages.content.toString();
            }
          }
        }
      } catch (error) {
      }
      return outputText;
    }

    String getState(LexResponse lexResponseObj) {
      String state = "";
      if (lexResponseObj != null) {
        if (lexResponseObj.sessionState != null
            && lexResponseObj.sessionState.intent != null
            && lexResponseObj.sessionState.intent.name.isNotEmpty
            && lexResponseObj.sessionState.intent.state != null
            && lexResponseObj.sessionState.intent.state.isNotEmpty) {
          state = lexResponseObj.sessionState.intent.state;
        }
      }
      return state;
    }

    Future<String> searchNotesByInput(String message) async {
      String answer = "";
      String notes = await getNotes();
      if (notes != null && notes != "") {
        answer = bertQAService
            .answer(notes,
            message)
            .first
            .text;
      }
      return answer;
    }

    Future<String> getNotes() async {
      List<TextNote> lstTextNote = await TextNoteService.loadNotes();
      var strBufffer = new StringBuffer();
      String notes = "";
      if (lstTextNote != null && lstTextNote.length > 0) {
        for (int i = 0; i < lstTextNote.length; i++) {
          TextNote textNote = lstTextNote.elementAt(i);
          if (textNote != null && textNote.noteId != null
              && textNote.noteId != "" && textNote.text != null
              && textNote.text != "") {
            strBufffer.write(textNote.text);
            strBufffer.write(". ");
          }
        }
      }
      if (strBufffer != null && strBufffer.toString() != null &&
          strBufffer.toString() != "") {
        notes = strBufffer.toString();
      }
      return notes;
    }

    Slots getSlots(LexResponse lexResponseObj) {
      Slots slots = new Slots(appointmentType: new AppointmentType(
          value: new Value(interpretedValue: "",
              originalValue: "", resolvedValues: new List.empty())),
          date: new AppointmentType(value: new Value(interpretedValue: "",
              originalValue: "", resolvedValues: new List.empty())),
          time: new AppointmentType(value: new Value(interpretedValue: "",
              originalValue: "", resolvedValues: new List.empty())));
      if (lexResponseObj != null) {
        if (lexResponseObj.sessionState != null
            && lexResponseObj.sessionState.intent != null
            && lexResponseObj.sessionState.intent.slots != null) {
          slots = lexResponseObj.sessionState.intent.slots;
        }
      }
      return slots;
    }

    NLUResponse getAppHelpResponse(LexResponse lexResponseObj,
        String currentState,
        String inputText,
        String outputText) {
      ActionType actionType = ActionType.APP_HELP;
      NLUState state = NLUState.COMPLETE;
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          null,
          null,
          null);
    }

    NLUResponse getAppNavResponse(LexResponse lexResponseObj,
        String currentState,
        String inputText,
        String outputText) {
      ActionType actionType = ActionType.APP_NAV;
      NLUState state = NLUState.COMPLETE;
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          null,
          null,
          null);
    }

    NLUResponse getCreateNoteResponse(LexResponse lexResponseObj,
        String currentState,
        String inputText,
        String outputText) {
      ActionType actionType = ActionType.CREATE_NOTE;
      NLUState state = NLUState.COMPLETE;
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          null,
          null,
          null);
    }

    Future<NLUResponse?> getSearchNoteResponse(LexResponse lexResponseObj,
        String currentState,
        String inputText) async {
      ActionType actionType = ActionType.CREATE_NOTE;
      NLUState state = NLUState.COMPLETE;
      String outputText = await searchNotesByInput(inputText);
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          null,
          null,
          null);
    }

    NLUResponse getCreateEventResponse(LexResponse lexResponseObj,
        String currentState,
        String inputText,
        String outputText,
        Slots? currentSlots) {
      ActionType actionType;
      NLUState state;
      List<String>? eventTypeResolved = getEventType(currentSlots);
      List<String>? eventDateResolved = getEventDate(currentSlots);
      List<String>? eventTimeResolved = getEventTime(currentSlots);
      List<String>? resolvedValues;
      String eventType = "",
          eventTime = "",
          eventDate = "";

      DateTime? eventDateTime;
      if (currentState == "InProgress") {
        actionType = ActionType.ANSWER;
        state = NLUState.INPROGRESS;
        if (eventTypeResolved != null && eventTypeResolved.length > 0 &&
            eventTypeResolved.length > 1) {
          resolvedValues = eventTypeResolved;
        } else if (eventDateResolved != null && eventDateResolved.length > 0 &&
            eventDateResolved.length > 1) {
          resolvedValues = eventDateResolved;
        } else if (eventTimeResolved != null && eventTimeResolved.length > 0 &&
            eventTimeResolved.length > 1) {
          resolvedValues = eventTimeResolved;
        }
      } else {
        actionType = ActionType.CREATE_EVENT;
        state = NLUState.COMPLETE;
        if (eventTypeResolved != null && eventTypeResolved.length > 0) {
          eventType = eventTypeResolved.first;
        }
        if (eventDateResolved != null && eventDateResolved.length > 0) {
          eventDate = eventDateResolved.first;
        }
        if (eventTimeResolved != null && eventTimeResolved.length > 0) {
          eventTime = eventTimeResolved.first;
        }
        eventDateTime = getEventDateTime(eventDateTime, eventDate, eventTime);
        outputText = "Book " + eventType + " appointment" + " at " + eventDateTime.toString();
      }
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          eventType,
          eventDateTime,
          resolvedValues);
    }

    DateTime getEventDateTime(DateTime? eventDateTime, String eventDate, String eventTime) {
      eventDateTime =  DateTime.parse(eventDate);
      List<String> hourMin =  eventTime.split(":");
      if (hourMin != null && hourMin.length > 0) {
        if (hourMin.first != null && hourMin.first.isNotEmpty) {
          int currentHour = int.parse(hourMin.first);
          eventDateTime =  eventDateTime.add(new Duration(hours: currentHour));
        }
        if (hourMin.last != null && hourMin.last.isNotEmpty) {
          int currentMin = int.parse(hourMin.last);
          eventDateTime =  eventDateTime.add(new Duration(minutes: currentMin));
        }
      }
      return eventDateTime;
    }

    List<String>? getEventType(Slots? slots) {
      if (slots != null
          && slots.appointmentType != null
          && slots.appointmentType!.value != null
          && slots.appointmentType!.value!.resolvedValues != null
          && slots.appointmentType!.value!.resolvedValues.length > 0) {
        return slots.appointmentType!.value!.resolvedValues;
      }
      return null;
    }

    List<String>? getEventDate(Slots? slots) {
      if (slots != null
          && slots.date != null
          && slots.date!.value != null
          && slots.date!.value!.resolvedValues != null
          && slots.date!.value!.resolvedValues.length > 0) {
        return slots.date!.value!.resolvedValues;
      }
      return null;
    }

    List<String>? getEventTime(Slots? slots) {
      if (slots != null
          && slots.time != null
          && slots.time!.value != null
          && slots.time!.value!.resolvedValues != null
          && slots.time!.value!.resolvedValues.length > 0) {
        return slots.time!.value!.resolvedValues;
      }
      return null;
    }

    NLUResponse getFallBackResponse(
        String inputText) {
      ActionType actionType = ActionType.NOTFOUND;
      String outputText = FallbackResponse;
      NLUState state = NLUState.COMPLETE;
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          null,
          null,
          null);
    }
  }