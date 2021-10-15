import '../Model/Note.dart';
import '../Utility/FileUtil.dart';
import 'package:uuid/uuid.dart';


/// Encapsulates all file I/O for text notes
class TextNoteService {

  static String FILE_NAME = "memory_notes.json";

  /// Constructor
  TextNoteService();

  /// Save a text note file to local storage
  static Future<List<TextNote>> loadNotes() async {
    print("Loading notes from file");
    List<TextNote> userTextNotes = [];
    dynamic listExtract = await FileUtil.readJson(FILE_NAME).then((value) => value);
    for( var note in listExtract){
      print("Loading notes from file $note");
      userTextNotes.add(TextNote.fromJson(note));        
    }
    return  userTextNotes;
  }

  /// Save a text note file to local storage
  static Future<void> persistNotes( List<TextNote> notes) async {
    print("Saving notes: "+ notes.toString());
    FileUtil.writeJson(FILE_NAME, "${notes.toString()}" );
  }



 static String generateUUID() {
    var uuid = Uuid();
    // Generate a v4 (random) id
    var v4 = uuid.v4(); // -> '110ec58a-a0f2-4ac4-8393-c866d813b8d1'
  return v4;
  }
}


