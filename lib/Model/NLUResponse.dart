
import 'package:untitled3/Model/NLUAction.dart';

class NLUResponse {
  NLUAction nluAction;
  String inputText;
  String response;
  NLUResponse(this.nluAction,
      this.inputText,
      this.response);
}