import 'package:mobx/mobx.dart';
import '../Model/Note.dart';
import '../Services/NoteService.dart';

part 'NoteObservable.g.dart';

class NoteObserver = _AbstractNoteObserver with _$NoteObserver;

abstract class _AbstractNoteObserver with Store {

  _AbstractNoteObserver(){
    TextNoteService.loadNotes().then((value) => setNotes(value));
  }

  @observable
  String currentScreen = "";

  @observable
  TextNote? currNoteForDetails;

  @observable 
  List<TextNote> usersNotes = []; 

  @action
  void addNote(TextNote note){
    print("Adding note to: ${note.noteId}");
    usersNotes.add(note);
    TextNoteService.persistNotes(usersNotes);
  }

  @action
  void deleteNote(TextNote? note){
    if(note == null){
      print("deleteNote: param is null");
      return;
    }
     //remove from state
     usersNotes.remove(note);
     //remove from storage by over-writing content 
     TextNoteService.persistNotes(usersNotes);
  }

  @action
  void setCurrNoteIdForDetails(noteId){
    print("Find Noteid: $noteId");
    
    for( TextNote note in usersNotes ){
        if(note.noteId == noteId){
          currNoteForDetails = note;
        }
    }
  }

  @action
  void setNotes(notes){
    print("set note to: ${notes}");
    usersNotes = notes;
  }

  @action
  void changeScreen(String name){
    print("Note Screen changed to: "+ name);
    currentScreen = name;
  }
}

