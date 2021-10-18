import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/LexResponse.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
import 'package:untitled3/Model/NLUState.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'LexService.dart';
import 'package:untitled3/Model/Note.dart';
import '../../NoteService.dart';
import '../BertQA/BertQaService.dart';

  class NLULibService {

    late final BertQAService bertQAService;
    late final LexService lexService;
    late final noteObserver;
    static const String FallbackResponse = "Sorry not able to understand.";
    static const String AppHelp = "AppHelp";
    static const String AppNav = "AppNav";
    static const String SearchNotes = "SearchNotes";
    static const String CreateNote = "CreateNote";
    static const String CreateEvent = "CreateEvent";
    static const String CreateActionEvent = "CreateActionEvent";
    static const String CreateRecurringEvent = "CreateRecurringEvent";
    static const String HowAreYou = "HowAreYou";
    static const String Hello = "Hello";
    static const String WhatIsYourName = "WhatIsYourName";
    static const String ThankYou = "ThankYou";
    static const String LastThingSaid = "LastThingSaid";
    static const String Compliment = "Compliment";
    static const String Insult = "Insult";
    static const String Goodbye = "Goodbye";
    static const String UserLocation = "UserLocation";
    static const String InterpretationsJsonStr = "interpretations";

    String lastValidInput = "";

    static const String DefaultLocale = "en-US";
    String previousSessionId = "";

    NLULibService() {
      lexService = LexService();
      bertQAService = BertQAService();
      noteObserver = Provider<NoteObserver>(create: (_) => NoteObserver());
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

          print(currentState);

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
            } else if (intentName == CreateActionEvent) {
              nluResponse = getCreateActionEventResponse(lexResponseObj,
                  currentState, inputText, outputText, currentSlots);
            } else if (intentName == SearchNotes) {
              nluResponse = (await getSearchNoteResponse(
                  inputText));
            } else if (intentName == CreateRecurringEvent) {
              nluResponse = getCreateRecurringResponse(lexResponseObj,
                  currentState, inputText, outputText, currentSlots);
            } else if (intentName == LastThingSaid) {
              nluResponse = getLastThingSaidResponse(lexResponseObj,
                  currentState, inputText, outputText);
            } else if (intentName == UserLocation) {
              nluResponse = getUserLocationResponse(lexResponseObj,
                  currentState, inputText, outputText);
            } else if (intentName == HowAreYou || intentName == Hello ||
                intentName == WhatIsYourName || intentName == ThankYou ||
                intentName == Compliment || intentName == Insult ||
                intentName == Goodbye) {
              nluResponse = getChitChatResponse(lexResponseObj,
                  currentState, inputText, outputText);
            } else {
              nluResponse = (await getSearchNoteResponse(inputText));
            }
          }
        }
      }
      if (nluResponse == null) {
        nluResponse = getFallBackResponse(inputText);
      }
      if (nluResponse.state == NLUState.IN_PROGRESS) {
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
      } catch (error) {}
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
      List<TextNote> notesObs = noteObserver.usersNotes;

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
            if (textNote.eventDate != null) {

            }
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
      Slots slots = new Slots(eventType: new EventType(
          value: new Value(interpretedValue: "",
              originalValue: "", resolvedValues: new List.empty())),
          date: new EventType(value: new Value(interpretedValue: "",
              originalValue: "", resolvedValues: new List.empty())),
          time: new EventType(value: new Value(interpretedValue: "",
              originalValue: "", resolvedValues: new List.empty())),
          recurringType: new RecurringType(
              value: new Value(interpretedValue: "",
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
      lastValidInput = inputText;
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          null,
          null,
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
      lastValidInput = inputText;
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          null,
          null,
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
      lastValidInput = inputText;
      outputText = inputText;
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          null,
          null,
          null,
          null,
          null);
    }

    Future<NLUResponse?> getSearchNoteResponse(String inputText) async {
      ActionType actionType = ActionType.ANSWER;
      NLUState state = NLUState.COMPLETE;
      lastValidInput = inputText;
      String outputText = await searchNotesByInput(inputText);
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          null,
          null,
          null,
          null,
          null);
    }

    NLUResponse getCreateRecurringResponse(LexResponse lexResponseObj,
        String currentState, String inputText,
        String outputText, Slots currentSlots) {
      ActionType actionType;
      NLUState state;
      List<String>? recurringTypeResolved = getRecurringEventType(currentSlots);
      List<String>? eventTimeResolved = getEventTime(currentSlots);
      List<String>? resolvedValues;
      String recurringType = "",
          eventTime = "";
      TimeOfDay? timeOfDay;

      if (currentState == "InProgress") {
        actionType = ActionType.ANSWER;
        state = NLUState.IN_PROGRESS;
        if (recurringTypeResolved != null && recurringTypeResolved.length > 0 &&
            recurringTypeResolved.length > 1) {
          resolvedValues = recurringTypeResolved;
        } else if (eventTimeResolved != null && eventTimeResolved.length > 0 &&
            eventTimeResolved.length > 1) {
          resolvedValues = eventTimeResolved;
        }
      } else {
        actionType = ActionType.CREATE_RECURRING_EVENT;
        state = NLUState.COMPLETE;
        if (recurringTypeResolved != null && recurringTypeResolved.length > 0) {
          recurringType = recurringTypeResolved.first;
        }
        if (eventTimeResolved != null && eventTimeResolved.length > 0) {
          eventTime = eventTimeResolved.first;
        }
        timeOfDay = getTimeOfDay(eventTime);
        outputText = inputText;
      }
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          null,
          null,
          resolvedValues,
          recurringType,
          timeOfDay);
    }

    NLUResponse getLastThingSaidResponse(LexResponse lexResponseObj,
        String currentState,
        String inputText,
        String outputText) {
      ActionType actionType = ActionType.ANSWER;
      NLUState state = NLUState.COMPLETE;
      if (lastValidInput
          .trim()
          .isNotEmpty) {
        outputText = "You said '$lastValidInput'.";
      } else {
        outputText = "You didn't say anything.";
      }
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          null,
          null,
          null,
          null,
          null);
    }

    NLUResponse getUserLocationResponse(LexResponse lexResponseObj,
        String currentState,
        String inputText,
        String outputText) {
      ActionType actionType = ActionType.USER_LOCATION;
      NLUState state = NLUState.COMPLETE;
      outputText = "";
      lastValidInput = inputText;
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          null,
          null,
          null,
          null,
          null);
    }

    NLUResponse getChitChatResponse(LexResponse lexResponseObj,
        String currentState,
        String inputText,
        String outputText) {
      ActionType actionType = ActionType.ANSWER;
      NLUState state = NLUState.COMPLETE;
      lastValidInput = inputText;
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          null,
          null,
          null,
          null,
          null);
    }

    NLUResponse? getCreateActionEventResponse(LexResponse lexResponseObj,
        String currentState, String inputText, String outputText,
        Slots currentSlots) {
      ActionType actionType;
      NLUState state;
      List<String>? actionEventTypeResolved = getActionEventType(currentSlots);
      List<String>? eventDateResolved = getEventDate(currentSlots);
      List<String>? eventTimeResolved = getEventTime(currentSlots);
      List<String>? resolvedValues;
      String actionEventType = "",
          eventTime = "",
          eventDate = "";

      DateTime? eventDateTime;
      if (currentState == "InProgress") {
        actionType = ActionType.ANSWER;
        state = NLUState.IN_PROGRESS;
        if (actionEventTypeResolved != null &&
            actionEventTypeResolved.length > 0 &&
            actionEventTypeResolved.length > 1) {
          resolvedValues = actionEventTypeResolved;
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
        if (actionEventTypeResolved != null &&
            actionEventTypeResolved.length > 0) {
          actionEventType = actionEventTypeResolved.first;
        }
        if (eventDateResolved != null && eventDateResolved.length > 0) {
          eventDate = eventDateResolved.first;
        }
        if (eventTimeResolved != null && eventTimeResolved.length > 0) {
          eventTime = eventTimeResolved.first;
        }
        eventDateTime = getEventDateTime(eventDateTime, eventDate, eventTime);
        outputText =
            "I shall " + actionEventType + " on " + eventDate + " at " +
                eventTime;
      }
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          actionEventType,
          eventDateTime,
          resolvedValues,
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
        state = NLUState.IN_PROGRESS;
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
        outputText =
            "I have a " + eventType + " on " + eventDate + " at " + eventTime;
      }
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          eventType,
          eventDateTime,
          resolvedValues,
          null,
          null);
    }

    DateTime getEventDateTime(DateTime? eventDateTime, String eventDate,
        String eventTime) {
      eventDateTime = DateTime.parse(eventDate);
      List<String> hourMin = eventTime.split(":");
      if (hourMin != null && hourMin.length > 0) {
        if (hourMin.first != null && hourMin.first.isNotEmpty) {
          int currentHour = int.parse(hourMin.first);
          eventDateTime = eventDateTime.add(new Duration(hours: currentHour));
        }
        if (hourMin.last != null && hourMin.last.isNotEmpty) {
          int currentMin = int.parse(hourMin.last);
          eventDateTime = eventDateTime.add(new Duration(minutes: currentMin));
        }
      }
      return eventDateTime;
    }

    TimeOfDay getTimeOfDay(String eventTime) {
      int currentHour = 0,
          currentMin = 0;
      if (eventTime.isNotEmpty) {
        List<String> hourMin = eventTime.split(":");
        if (hourMin != null && hourMin.length > 0) {
          if (hourMin.first != null && hourMin.first.isNotEmpty) {
            currentHour = int.parse(hourMin.first);
          }
          if (hourMin.last != null && hourMin.last.isNotEmpty) {
            currentMin = int.parse(hourMin.last);
          }
        }
      }
      return TimeOfDay(hour: currentHour, minute: currentMin);;
    }

    List<String>? getEventType(Slots? slots) {
      if (slots != null
          && slots.eventType != null
          && slots.eventType!.value != null
          && slots.eventType!.value!.resolvedValues != null
          && slots.eventType!.value!.resolvedValues.length > 0) {
        return slots.eventType!.value!.resolvedValues;
      }
      return null;
    }

    List<String>? getRecurringEventType(Slots? slots) {
      if (slots != null
          && slots.recurringType != null
          && slots.recurringType!.value != null
          && slots.recurringType!.value!.resolvedValues != null
          && slots.recurringType!.value!.resolvedValues.length > 0) {
        return slots.recurringType!.value!.resolvedValues;
      }
      return null;
    }

    List<String>? getActionEventType(Slots slots) {
      if (slots != null
          && slots.actionEventType != null
          && slots.actionEventType!.value != null
          && slots.actionEventType!.value!.resolvedValues != null
          && slots.actionEventType!.value!.resolvedValues.length > 0) {
        return slots.actionEventType!.value!.resolvedValues;
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

    NLUResponse getFallBackResponse(String inputText) {
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
          null,
          null,
          null);
    }

  }

