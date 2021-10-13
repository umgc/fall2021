
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../Services/NoteService.dart';

class TextNote {
  TextNote();
  /// Name of the text note file
  String noteId = TextNoteService.generateUUID();

  /// Date and time when the text note was recorded
  DateTime recordedTime = DateTime.now();

  //locale 
  String recordLocale = "us";

  //locale 
  String preferredLocale = "us";

  //true for check list Item
  bool isCheckList = false;

  //true for check list Item
  bool isEvent = false;

  /// Actual text of the text note
  String text = "";

  /// Whether or not this text file is flagged as a favorite
  bool isFavorite = false;

  /// Date and time of event
  DateTime eventDate = DateTime.now() ;

  String toJson() {
    String jsonStr = """ {"noteId": "${this.noteId}",
                        "recordedTime": "${this.recordedTime}",
                        "recordLocale": "${this.recordLocale}",
                        "preferredLocale": "${this.preferredLocale}",
                        "isCheckList": ${this.isCheckList},
                        "isEvent": ${this.isEvent},
                        "text": "${this.text}",
                        "isFavorite": ${this.isFavorite},
                        "eventDate": "${this.eventDate}"}""";
    return jsonStr;
  }


  factory TextNote.fromJson(dynamic jsonObj) {
    TextNote note = TextNote();
    print("extracting jsonObj $jsonObj");
    note.noteId = jsonObj['noteId'];
    note.recordedTime = DateTime.parse(jsonObj['recordedTime']);
    note.recordLocale = jsonObj['recordLocale'];
    note.preferredLocale = jsonObj['preferredLocale'];
    note.isCheckList = jsonObj['isCheckList'];
    note.isEvent = jsonObj['isEvent'];
    note.text = jsonObj['text'];
    note.isFavorite = jsonObj['isFavorite'];
    note.eventDate = DateTime.tryParse(jsonObj['eventDate'])!;
    return note;
  }

  @override
  String toString(){
      return this.toJson();
  }

}



