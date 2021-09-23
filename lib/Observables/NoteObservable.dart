import 'package:mobx/mobx.dart';
import '../Model/Note.dart';
import '../Services/NoteService.dart';

part 'NoteObservable.g.dart';

class NoteObserver = _AbstractNoteObserver with _$NoteObserver;

abstract class _AbstractNoteObserver with Store {

  TextNoteService noteService = TextNoteService();

  _AbstractNoteObserver(){
    noteService.loadNotes().then((value) => setNotes(value));
  }

  @observable
  String currentScreen = "";

  @observable 
  List<TextNote> usersNotes = []; 

  @action
  void addNote(TextNote note){
    print("Adding note to: ${note.noteId}");
    usersNotes.add(note);
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

