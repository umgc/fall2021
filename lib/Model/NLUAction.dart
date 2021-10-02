import 'package:json_annotation/json_annotation.dart';

@JsonSerializable(nullable: true)
enum ActionType {
  CREATE_NOTE,
  COMPLETE,
  INCOMPLETE,
  APP_HELP,
  APP_NAV
}