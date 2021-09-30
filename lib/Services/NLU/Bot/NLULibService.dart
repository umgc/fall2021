
import 'package:untitled3/Model/NLUAction.dart';
import 'package:untitled3/Model/NLUResponse.dart';

import '../BertQA/BertQaService.dart';
import 'LexService.dart';

  class NLULibService {

    late final BertQAService bertQAService;
    late final LexService lexService;
    // late
    NLULibService() {
      bertQAService = BertQAService();
      lexService = LexService();
    }

    Future<NLUResponse> process(String message) async {
      //Future<dynamic?>? lexResponse = await lexService.postResponse(
      //    text: message);
      String response = searchNotes(message);
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
    }
  }