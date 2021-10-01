
import 'dart:convert';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:untitled3/Model/LexResponse.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
import 'package:untitled3/Model/Note.dart';

import '../../NoteService.dart';
import '../BertQA/BertQaService.dart';
import 'LexService.dart';

  class NLULibService {

    late final BertQAService bertQAService;
    late final LexService lexService;

    NLULibService() {
      lexService = LexService();
      bertQAService = BertQAService();
    }


    Future<String> getNLUResponseUITest(String text) async {
      NLUResponse nluResponse = (await getNLUResponse(text, "en-US"));
      String response = nluResponse.toJson().toString();
      return response;
    }

    Future<NLUResponse> getNLUResponse(String inputText, String locale) async {
      NLUResponse nluResponse;
      ActionType actionType = ActionType.Complete;
      String outputText = "";
      String sessionId = TextNoteService.generateUUID();
      Map<String, dynamic> lexResponse = await lexService.getLexResponse(
          text: inputText,userId: sessionId,locale: locale );
      var lexResponseObj = LexResponse.fromJson(lexResponse);
      if (lexResponseObj != null) {
        String intentName = getIntentName(lexResponseObj);
        if (intentName.isNotEmpty) {
          if (intentName.startsWith("AppHelp")) {
            actionType = EnumToString.fromString(
                ActionType.values, intentName)!; //, TestEnum.ValueOne
            outputText = getMessage(lexResponseObj);
          } else if (intentName == "SearchNotes") {
            actionType = ActionType.Complete;
            outputText = await searchNotes(inputText);
          }
        }
      }
      nluResponse = new NLUResponse(actionType, inputText, outputText);
      return nluResponse;
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
      return outputText;
    }

    Future<String> searchNotes(String message) async {
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
          }
        }
      }
      if (strBufffer != null && strBufffer.toString() != null &&
          strBufffer.toString() != "") {
        notes = strBufffer.toString();
      }
      return notes;
    }
  }