fiximport 'package:untitled3/Model/LexResponse.dart';
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';
import 'package:untitled3/Model/Note.dart';
import '../../NoteService.dart';
import '../BertQA/BertQaService.dart';
import 'LexService.dart';

  class NLULibService {

    late final BertQAService bertQAService;
    late final LexService lexService;
    static const String FallbackResponse = "Sorry not able to understand.";
    static const String AppHelp = "AppHelp";
    static const String AppNav = "AppNav";
    static const String SearchNotes = "SearchNotes";
    static const String CreateNote = "CreateNote";
    static const String InterpretationsJsonStr = "interpretations";
    static const String DefaultLocale = "en-US";
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
      NLUResponse nluResponse;
      ActionType actionType = ActionType.INCOMPLETE;
      String outputText = "";
      String sessionId = TextNoteService.generateUUID();
      Map<String, dynamic> lexResponse = await lexService.getLexResponse(
          text: inputText, userId: sessionId, locale: locale);
      if (lexResponse[InterpretationsJsonStr] != null) {
        var lexResponseObj = LexResponse.fromJson(lexResponse);
        if (lexResponseObj != null) {
          String intentName = getIntentName(lexResponseObj);
          if (intentName.isNotEmpty) {
            if (intentName.startsWith(AppHelp)) {
              actionType = ActionType.APP_HELP;
              outputText = getMessage(lexResponseObj);
            } else if (intentName.startsWith(AppNav)) {
              actionType = ActionType.APP_NAV;
              outputText = getMessage(lexResponseObj);
            } else if (intentName == CreateNote) {
              actionType = ActionType.CREATE_NOTE;
              outputText = inputText;
            } else if (intentName == SearchNotes) {
              actionType = ActionType.COMPLETE;
              outputText = await searchNotesByInput(inputText);
            }
          }
        }
      } else {
        actionType = ActionType.INCOMPLETE;
        outputText = FallbackResponse;
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
  }