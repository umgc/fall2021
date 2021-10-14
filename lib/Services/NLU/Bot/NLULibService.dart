import 'package:flutter/material.dart';
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
    static const String CreateEvent = "CreateEvent";
    static const String CreateActionEvent = "CreateActionEvent";
    static const String CreateRecurringEvent = "CreateRecurringEvent";
    static const String CreateRecurringActionEvent = "CreateRecurringActionEvent";
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
            } else if (intentName == CreateEvent || intentName == CreateRecurringEvent) {
              nluResponse = getCreateEventResponse(lexResponseObj,
                  currentState, inputText, outputText, currentSlots);
            } else if (intentName == CreateActionEvent || intentName == CreateRecurringActionEvent) {
              nluResponse = getCreateActionEventResponse(lexResponseObj,
                  currentState, inputText, outputText, currentSlots);
            } else if (intentName == SearchNotes) {
              nluResponse = (await getSearchNoteResponse(
                  inputText));
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
      Slots slots = new Slots(
          eventType: new EventType(value: new Value(interpretedValue: "",
              originalValue: "", resolvedValues: new List.empty())),
          date: new EventType(value: new Value(interpretedValue: "",
              originalValue: "", resolvedValues: new List.empty())),
          time: new EventType(value: new Value(interpretedValue: "",
              originalValue: "", resolvedValues: new List.empty())),
          recurringType: new RecurringType(value: new Value(interpretedValue: "",
                  originalValue: "", resolvedValues: new List.empty())),
          actionEventType: new ActionEventType(value: new Value(interpretedValue: "",
              originalValue: "", resolvedValues: new List.empty())),
          auxiliaryVerbType: new AuxiliaryVerbType(value: new Value(interpretedValue: "",
              originalValue: "", resolvedValues: new List.empty()))
      );
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
          null,
          null);
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
          null,
          null);
    }

    NLUResponse? getCreateActionEventResponse(LexResponse lexResponseObj,
        String currentState, String inputText, String outputText,
        Slots currentSlots) {

      ActionType actionType;
      NLUState state;

      String? recurringType = getRecurringType(currentSlots);
      String? subjectType = getSubjectType(currentSlots);
      String? auxiliaryVerbType = getAuxiliaryVerbType(currentSlots);
      String? actionEventType = getActionEventType(currentSlots);
      List<String>? eventDateResolved = getEventDate(currentSlots, recurringType);
      List<String>? eventTimeResolved = getEventTime(currentSlots, recurringType);
      List<String>? resolvedValues;

      String eventTime = "",
          eventDate = "";

      if (currentState == "InProgress") {
        actionType = ActionType.ANSWER;
        state = NLUState.IN_PROGRESS;
        if (eventDateResolved != null &&
            eventDateResolved.length > 1) {
          resolvedValues = eventDateResolved;
        } else if (eventTimeResolved != null &&
            eventTimeResolved.length > 1) {
          resolvedValues = eventTimeResolved;
        }
      } else {
        actionType = ActionType.CREATE_NOTE;
        state = NLUState.COMPLETE;
        if (eventDateResolved != null && eventDateResolved.length > 0) {
          eventDate = eventDateResolved.first;
        }
        if (eventTimeResolved != null && eventTimeResolved.length > 0) {
          eventTime = eventTimeResolved.first;
        }
        if (subjectType != null && auxiliaryVerbType != null && actionEventType != null) {
          outputText = subjectType + " " + auxiliaryVerbType + " " + actionEventType;
          lastValidInput = outputText;
          if (recurringType != null) {
            lastValidInput += " " + recurringType;
          }
          if (eventDate.isNotEmpty && recurringType != null) {
            outputText += " on "+eventDate;
            lastValidInput += " on "+eventDate;
          }
          if (eventTime.isNotEmpty && recurringType != null) {
            outputText += " at "+eventTime;
            lastValidInput += " at "+eventTime;
          }
        }
      }
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          actionEventType,
          eventDate,
          eventTime,
          resolvedValues,
          recurringType,
          null);
    }

    NLUResponse getCreateEventResponse(LexResponse lexResponseObj,
        String currentState, String inputText, String outputText,
        Slots? currentSlots) {

      ActionType actionType;
      NLUState state;

      String? recurringType = getRecurringType(currentSlots);
      String? subjectType = getSubjectType(currentSlots);
      String? eventType = getEventType(currentSlots);
      String? haveType = getHaveType(currentSlots);
      String? beType = getBeType(currentSlots);

      List<String>? eventDateResolved = getEventDate(currentSlots, recurringType);
      List<String>? eventTimeResolved = getEventTime(currentSlots, recurringType);
      List<String>? resolvedValues;

      String eventTime = "",
          eventDate = "";

      if (currentState == "InProgress") {
        actionType = ActionType.ANSWER;
        state = NLUState.IN_PROGRESS;
        if (eventDateResolved != null &&
            eventDateResolved.length > 1) {
          resolvedValues = eventDateResolved;
        } else if (eventTimeResolved != null &&
            eventTimeResolved.length > 1) {
          resolvedValues = eventTimeResolved;
        }
      } else {
        actionType = ActionType.CREATE_NOTE;
        state = NLUState.COMPLETE;
        if (eventDateResolved != null && eventDateResolved.length > 0) {
          eventDate = eventDateResolved.first;
        }
        if (eventTimeResolved != null && eventTimeResolved.length > 0) {
          eventTime = eventTimeResolved.first;
        }
        if (subjectType != null && haveType != null && eventType != null) {
          outputText = subjectType + " " + haveType + " " + eventType;
          lastValidInput = outputText;
          if (recurringType != null) {
            lastValidInput += " " + recurringType;
          }
          if (eventDate.isNotEmpty && recurringType != null) {
            outputText += " on "+eventDate;
            lastValidInput += " on "+eventDate;
          }
          if (eventTime.isNotEmpty && recurringType != null) {
            outputText += " at "+eventTime;
            lastValidInput += " at "+eventTime;
          }
        } else if (beType != null && eventType != null) {
          outputText = "There " + beType + " " + eventType;
          lastValidInput = outputText;
          if (recurringType != null) {
            lastValidInput += " " + recurringType;
          }
          if (eventDate.isNotEmpty && recurringType != null) {
            outputText += " on "+eventDate;
            lastValidInput += " on "+eventDate;
          }
          if (eventTime.isNotEmpty && recurringType != null) {
            outputText += " at "+eventTime;
            lastValidInput += " at "+eventTime;
          }
        }
      }
      return new NLUResponse(
          actionType,
          inputText,
          outputText,
          state,
          eventType,
          eventDate,
          eventTime,
          resolvedValues,
          recurringType,
          null);
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
      return TimeOfDay(hour: currentHour, minute: currentMin);
    }

    String? getRecurringType(Slots? slots) {
      if (slots != null
          && slots.recurringType != null
          && slots.recurringType!.value != null
          && slots.recurringType!.value!.interpretedValue.isNotEmpty) {
        return slots.recurringType!.value!.interpretedValue;
      }
      return null;
    }

    String? getSubjectType(Slots? slots) {
      if (slots != null
          && slots.subjectType != null
          && slots.subjectType!.value != null
          && slots.subjectType!.value!.interpretedValue.isNotEmpty) {
        return slots.subjectType!.value!.interpretedValue;
      }
      return null;
    }

    String? getAuxiliaryVerbType(Slots? slots) {
      if (slots != null
          && slots.auxiliaryVerbType != null
          && slots.auxiliaryVerbType!.value != null
          && slots.auxiliaryVerbType!.value!.interpretedValue.isNotEmpty) {
        return slots.auxiliaryVerbType!.value!.interpretedValue;
      }
      return null;
    }

    String? getHaveType(Slots? slots) {
      if (slots != null
          && slots.haveType != null
          && slots.haveType!.value != null
          && slots.haveType!.value!.interpretedValue.isNotEmpty) {
        return slots.haveType!.value!.interpretedValue;
      }
      return null;
    }

    String? getBeType(Slots? slots) {
      if (slots != null
          && slots.beType != null
          && slots.beType!.value != null
          && slots.beType!.value!.interpretedValue.isNotEmpty) {
        return slots.beType!.value!.interpretedValue;
      }
      return null;
    }

    String? getEventType(Slots? slots) {
      if (slots != null
          && slots.eventType != null
          && slots.eventType!.value != null
          && slots.eventType!.value!.interpretedValue.isNotEmpty) {
        return slots.eventType!.value!.interpretedValue;
      }
      return null;
    }

    String? getActionEventType(Slots? slots) {
      if (slots != null
          && slots.actionEventType != null
          && slots.actionEventType!.value != null
          && slots.actionEventType!.value!.interpretedValue.isNotEmpty) {
        return slots.actionEventType!.value!.interpretedValue;
      }
      return null;
    }

    List<String>? getEventDate(Slots? slots, String? recurringType) {
      if (recurringType != null) {
        if (slots != null
            && slots.date != null
            && slots.date!.value != null
            && slots.date!.value!.originalValue.isNotEmpty) {
          return new List.from([slots.date!.value!.originalValue]);
        }
      } else {
        if (slots != null
            && slots.date != null
            && slots.date!.value != null
            && slots.date!.value!.resolvedValues.length > 0) {
          return slots.date!.value!.resolvedValues;
        }
      }
      return null;
    }

    List<String>? getEventTime(Slots? slots, recurringType) {
      if (recurringType != null) {
        if (slots != null
            && slots.time != null
            && slots.time!.value != null
            && slots.time!.value!.originalValue.isNotEmpty) {
          return new List.from([slots.time!.value!.originalValue]);
        }
      } else {
        if (slots != null
            && slots.time != null
            && slots.time!.value != null
            && slots.time!.value!.resolvedValues.length > 0) {
          return slots.time!.value!.resolvedValues;
        }
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
          null,
          null);
    }

    String formatDate(String date) {

      return "";
    }

    String formatTime(String Time) {

      return "";
    }
  }

