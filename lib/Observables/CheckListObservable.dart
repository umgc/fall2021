import 'package:mobx/mobx.dart';
import 'dart:collection';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Services/NoteService.dart';
part 'CheckListObservable.g.dart';

class CheckListObserver = _AbstractCheckListObserver with _$CheckListObserver;

abstract class _AbstractCheckListObserver with Store {
  _AbstractCheckListObserver() {
    //load todays checklist at init.
  }
  @observable
  NoteObserver noteObserver = NoteObserver();

  @observable
  List<TextNote> dailyCheckList = [];

  @observable
  List<String> checkedNoteIDs = [];

  @action
  void setNotObserver(NoteObserver observer) {
    print("setNotObserver(): Observer set");
    noteObserver = observer;
  }

  @action
  void getDailyCheckList(String date) {
    print("Getting checklist");
    TextNoteService.getDailyCheckedNote(date)
        .then((value) => checkedNoteIDs = value.split(","));
    print("getDailyCheckList $checkedNoteIDs");
    if (noteObserver == null) {
      print("getDailyCheckList(): noteObserver is $noteObserver");
      return;
    }
    print("getDailyCheckList(): noteObserver is $noteObserver");

    for (TextNote note in noteObserver.usersNotes) {
      if (note.isCheckList == true) {
        dailyCheckList.add(note);
        print("getDailyCheckList(): dailyCheckList is $dailyCheckList");
      }
    }
  }

  @action
  void addToCheckedItems(TextNote note) {
    print("addToCheckedItems: checkedNoteIDs ${checkedNoteIDs.length}");
    print("addToCheckedItems: note.noteId ${note.noteId}");
    checkedNoteIDs.add(note.noteId);

    TextNoteService.persistDailyCheckedNotes(checkedNoteIDs.join(","));
  }

  @action
  void addUnCheckItem(TextNote note) {
    checkedNoteIDs.add(note.noteId);

    TextNoteService.persistDailyCheckedNotes(checkedNoteIDs.join(","));
  }
}
