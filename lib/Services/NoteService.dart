import '../Model/Note.dart';
import '../Utility/FileUtil.dart';


/// Encapsulates all file I/O for text notes
class TextNoteService {

  static String FILE_NAME = "memory_notes.json";

  /// Constructor
  TextNoteService();

  /// Save a text note file to local storage
  Future<List<TextNote>> loadNotes() async {
    List<TextNote> userTextNotes = [];
    TextNote textNote; 
    dynamic listExtract = await FileUtil.readJson(FILE_NAME).then((value) => value);
    for(  dynamic note in listExtract){
      textNote = TextNote.fromJson(note);
      userTextNotes.add(textNote);        
    }
    return  userTextNotes;
  }

  /// Save a text note file to local storage
  Future<dynamic> persistNotes( List<TextNote> notes) async {
    print("Saving notes: "+ notes.toString());
    var data =  await FileUtil.writeJson(FILE_NAME, "${notes.toString()}" );
    return data;
  }
 
}


