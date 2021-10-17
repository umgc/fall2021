import 'package:mobx/mobx.dart';
import 'package:untitled3/Utility/Constant.dart';
import '../Model/Note.dart';
import '../Services/NoteService.dart';

part 'NoteObservable.g.dart';

class NoteObserver = _AbstractNoteObserver with _$NoteObserver;

abstract class _AbstractNoteObserver with Store {
  _AbstractNoteObserver() {
    TextNoteService.loadNotes().then((value) => setNotes(value));
  }

  @observable
  NOTE_SCREENS currentScreen = NOTE_SCREENS.NOTE;

  @observable
  TextNote? currNoteForDetails;

  @observable
  List<TextNote> usersNotes = [];

  //used when creating new note
  @observable
  bool newNoteIsCheckList = false;

  @observable
  String newNoteEventDate = "";

  @observable
  String newNoteEventTime = "";

  @action
  void addNote(TextNote note) {
    print("Adding note to: ${note.noteId}");
    usersNotes.add(note);
    TextNoteService.persistNotes(usersNotes);
  }

  @action
  void deleteNote(TextNote? note) {
    if (note == null) {
      print("deleteNote: param is null");
      return;
    }
    //remove from state
    usersNotes.remove(note);
    //remove from storage by over-writing content
    TextNoteService.persistNotes(usersNotes);
  }

  @action
  void setCurrNoteIdForDetails(noteId) {
    print("Find Noteid: $noteId");

    for (TextNote note in usersNotes) {
      if (note.noteId == noteId) {
        currNoteForDetails = note;
      }
    }
  }

  @action
  void setNotes(notes) {
    print("set note to: ${notes}");
    usersNotes = notes;
  }

  @action
  void changeScreen(NOTE_SCREENS name) {
    print("Note Screen changed to: $name");
    currentScreen = name;
  }

  /*
  * Actions for creating new notes
  */
  @action
  void setNewNoteAIsCheckList(bool value) {
    newNoteIsCheckList = value;
  }

  @action
  void setNewNoteEventDate(String value) {
    print("setNewNoteEventDate: setting new Note date '${value}'");
    newNoteEventDate = value;
  }

  @action
  void setNewNoteEventTime(String value) {
    print("setNewNoteEventTime: setting new Note time '${value}'");
    newNoteEventTime = value;
  }
}
