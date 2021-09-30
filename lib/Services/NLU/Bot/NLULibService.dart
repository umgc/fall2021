
import 'dart:convert';

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
      NLUResponse nluResponse = (await getNLUResponse(text));
      String response = nluResponse.toJson().toString();
      return response;
    }

    Future<NLUResponse> getNLUResponse(String message) async {
      Map<String, dynamic> lexResponse = await lexService.getLexResponse(
          text: message);
      String response = await searchNotes(message);
      return new NLUResponse(NLUAction.Answer, message, response);
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