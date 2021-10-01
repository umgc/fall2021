
import 'package:untitled3/Model/NLUAction.dart';
import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
class NLUResponse {
  ActionType actionType;
  String inputText;
  String outputText;

  NLUResponse(this.actionType,
      this.inputText,
      this.outputText);

  String toJson() {
    String jsonStr = """{"actionType": "${this.actionType}",
                        "inputText": "${this.inputText}",
                        "response": "${this.outputText}""";
    return jsonStr;
  }
}