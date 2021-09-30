
import 'package:untitled3/Model/NLUAction.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class NLUResponse {
  NLUAction nluAction;
  String inputText;
  String response;
  NLUResponse(this.nluAction,
      this.inputText,
      this.response);

  String toJson() {
    String jsonStr = """{"nluAction": "${this.nluAction}",
                        "inputText": "${this.inputText}",
                        "response": "${this.response}""";
    return jsonStr;
  }
}