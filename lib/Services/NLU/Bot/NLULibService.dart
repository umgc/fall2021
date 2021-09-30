
import 'dart:convert';

import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';

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

    String searchNotes(String message) {
      // ToDO get Notes
      String answer = bertQAService
          .answer(
          "I have a toothache. I have an appointment with "
              "dentist on monday oct 5th at 9 am. My wife blood pressure is 138."
              " My blood pressure is 140 above."
              " I have a dinner on octobher 5, Raj, DJ are coming.",
          message)
          .first
          .text;
      return answer;
      //return "";
    }

  }