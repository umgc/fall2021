
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

  String toJson() {
    String jsonStr = """{"noteId": "${this.noteId}",
                        "recordedTime": "${this.recordedTime}",
                        "recordLocale": "${this.recordLocale}",
                        "preferredLocale": "${this.preferredLocale}",
                        "isCheckList": ${this.isCheckList},
                        "isEvent": ${this.isEvent},
                        "text": "${this.text}",
                        "isFavorite": ${this.isFavorite}}""";

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
    return note;
  }

  @override
  String toString(){
      return this.toJson();
  }

}

/// Defines a specific personal detail
class PersonalDetail {
  /// Name of the personal detail file
  String fileName;

  /// key of the personal detail
  String key;

  /// value of the personal detail
  String value;

  /// Constructor takes all properties as params
  PersonalDetail(this.fileName, this.key, this.value);
}



/// Defines the settings object
class Setting {
  /// days to keep files before clearing them
  String daysToKeepFiles;

  /// seconds to listen before stopping a recording
  String secondsSilence;

  /// path to the wake word file
  String pathToWakeWord;

  /// Constructor takes all properties as params
  Setting(this.daysToKeepFiles, this.secondsSilence, this.pathToWakeWord);
}