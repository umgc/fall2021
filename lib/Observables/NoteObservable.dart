import 'package:mobx/mobx.dart';
import '../Model/Note.dart';
import '../Services/NoteService.dart';

part 'NoteObservable.g.dart';

class NoteScreenNav = _AbstractNoteScreen with _$NoteScreenNav;

abstract class _AbstractNoteScreen with Store {

  TextNoteService noteService = TextNoteService();

  _AbstractNoteScreen(){
    loadNotes();
  }

  @observable
  String currentScreen = "";

  @observable 
  List<TextNote> usersNotes = []; 

  @action
  void addNote(TextNote note){
    print("Adding note to: ${note.noteId}");
    usersNotes.add(note);
    saveNote(usersNotes);
  }

  void loadNotes(){
    noteService.loadNotes().then((value) => setNotes(value));
  }

  void saveNote(List<TextNote> usersNotes){
    print("Saving notes to");
    noteService.persistNotes(usersNotes);
  }
  
  
  @action
  void setNotes(notes){
    print("set note to: ${notes}");
    usersNotes = notes;
  }

  @action
  void changeScreen(String name){
    print("Screen changed to: "+ name);
    currentScreen = name;
  }

}

