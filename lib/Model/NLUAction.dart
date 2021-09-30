import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
enum NLUAction {
  CreateNote,
  Answer,
  CreateAppointment,
  SystemAction
}