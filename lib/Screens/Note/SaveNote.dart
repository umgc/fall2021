import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Services/NoteService.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import '../../Observables/NoteObservable.dart';
import 'package:share_plus/share_plus.dart';

final saveNoteScaffoldKey = GlobalKey<ScaffoldState>();

/// Save Note page
class SaveNote extends StatefulWidget {
  bool isCheckListEvent;
  bool viewExistingNote;

  SaveNote({this.isCheckListEvent = false, this.viewExistingNote = false}) {}

  @override
  State<SaveNote> createState() => _SaveNoteState(
      isCheckListEvent: this.isCheckListEvent,
      viewExistingNote: this.viewExistingNote);
}

class _SaveNoteState extends State<SaveNote> {
  /// Text note service to use for I/O operations against local system
  final TextNoteService textNoteService = new TextNoteService();
  bool isCheckListEvent;
  bool viewExistingNote;

  var textController = TextEditingController();
  TextNote _newNote = TextNote();
  _SaveNoteState(
      {this.isCheckListEvent = false, this.viewExistingNote = false}) {
    //this.navScreenObs = navScreenObs;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void _showToast() {
    Fluttertoast.showToast(
        msg: I18n.of(context)!.noteSaved,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 4);
  }

  //ref: https://api.flutter.dev/flutter/material/Checkbox-class.html
  Widget _checkBox() {
    final noteObserver = Provider.of<NoteObserver>(context);

    Color getColor(Set<MaterialState> states) {
      return Colors.blue;
    }

    return Row(
      children: [
        Text("Make this a daily activity"),
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: noteObserver.newNoteIsCheckList,
          onChanged: (bool? value) {
            print("Checkbox onChanged $value");
            noteObserver.setNewNoteAIsCheckList(value!);
          },
        )
      ],
    );
  }

  //ref: https://pub.dev/packages/date_time_picker
  Widget _selectDate() {
    final noteObserver = Provider.of<NoteObserver>(context);

    if (this.viewExistingNote == true) {
      return DateTimePicker(
        type: (noteObserver.newNoteIsCheckList || this.isCheckListEvent == true)
            ? DateTimePickerType.time
            : DateTimePickerType.dateTimeSeparate,
        dateMask: 'd MMM, yyyy',
        initialValue: (noteObserver.newNoteIsCheckList == true ||
                this.isCheckListEvent == true)
            ? (noteObserver.currNoteForDetails!.eventTime)
            : (noteObserver.currNoteForDetails!.eventDate +
                " " +
                noteObserver.currNoteForDetails!.eventTime),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
        icon: Icon(Icons.event),
        dateLabelText: 'DATE',
        timeLabelText: "TIME",
        selectableDayPredicate: (date) {
          return true;
        },
        onChanged: (value) {
          print("_selectDate: Datetime $value");

          if (noteObserver.newNoteIsCheckList == true) {
            noteObserver.setNewNoteEventTime(value);
          } else {
            String mDate = value.split(" ")[0];
            String mTime = value.split(" ")[1];
            noteObserver.setNewNoteEventDate(mDate);
            noteObserver.setNewNoteEventTime(mTime);
          }
        },
        validator: (val) {
          print(val);
          return null;
        },
        onSaved: (val) => print("onSaved $val"),
      );
    }

    //print(
    //  "noteObserver.currNoteForDetails!.eventDate ${(noteObserver.currNoteForDetails!.eventDate + ' ' + noteObserver.currNoteForDetails!.eventTime)}");

    return DateTimePicker(
      type: (isCheckListEvent)
          ? DateTimePickerType.time
          : DateTimePickerType.dateTimeSeparate,
      dateMask: 'd MMM, yyyy',
      initialValue: DateTime.now().toString(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      dateLabelText: 'DATE',
      timeLabelText: "TIME",
      selectableDayPredicate: (date) {
        return true;
      },
      onChanged: (value) {
        if (isCheckListEvent == true) {
          noteObserver.setNewNoteEventTime(value);
        } else {
          String mDate = value.split(" ")[0];
          String mTime = value.split(" ")[1];
          noteObserver.setNewNoteEventDate(mDate);
          noteObserver.setNewNoteEventTime(mTime);
        }
      },
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) => print("onSaved $val"),
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context);
    String noteId = "";
    //VIEW_NOTE MODE: Populated the details of the targeted notes into the UI
    if (noteObserver.currNoteForDetails != null) {
      noteId = noteObserver.currNoteForDetails!.noteId;

      textController =
          TextEditingController(text: noteObserver.currNoteForDetails!.text);
    }

    var padding = MediaQuery.of(context).size.width * 0.02;

    var verticalColSpace = MediaQuery.of(context).size.width * 0.1;

    return Scaffold(
        key: saveNoteScaffoldKey,
        body: Observer(
          builder: (context) => Container(
              padding: EdgeInsets.all(padding),
              child: Column(
                children: [
                  TextField(
                    controller: textController,
                    maxLines: 5,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: I18n.of(context)!.enterNoteText),
                  ),
                  SizedBox(height: verticalColSpace),

                  //only show check box if the user is edititing not
                  if (noteId.isEmpty) _checkBox(),

                  SizedBox(height: verticalColSpace),

                  //do not show if user chose to add checkList or modify and existing not to be a checklist
                  _selectDate(),

                  SizedBox(height: verticalColSpace),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 0, top: 4, right: 0, bottom: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        _onSave(noteObserver);
                      },
                      child: Text(
                        I18n.of(context)!.save,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 0, top: 2, right: 0, bottom: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        noteObserver.changeScreen(NOTE_SCREENS.NOTE);
                      },
                      child: Text(
                        I18n.of(context)!.cancel,
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      style: ElevatedButton.styleFrom(primary: Colors.grey),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(
                        left: 0, top: 50, right: 0, bottom: 0),
                    child: ElevatedButton(
                      onPressed: () {
                        Share.share(noteObserver.currNoteForDetails!.text);
                      },
                      child: Text(
                        'Share',
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                    ),
                  ),
                ],
              )),
          //bottomNavigationBar: BottomBar(3),
        ));
  }

  _onSave(NoteObserver noteObserver) {
    if (textController.text.length > 0) {
      this._newNote.text = textController.text;
      this._newNote.eventTime = noteObserver.newNoteEventTime;
      this._newNote.eventDate = noteObserver.newNoteEventDate;
      this._newNote.isCheckList = noteObserver.newNoteIsCheckList;
      noteObserver.deleteNote(noteObserver.currNoteForDetails);
      noteObserver.addNote(_newNote);
      _showToast();
      noteObserver.changeScreen(NOTE_SCREENS.NOTE);
    }
  }

  /// Show a dialog message confirming note was saved
  showConfirmDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text(I18n.of(context)!.ok),
      onPressed: () {
        //navScreenObs.changeScreen(SCREEN_NAMES.NOTE);
      },
    );

    // set up the dialog
    AlertDialog alert = AlertDialog(
      content: Text(I18n.of(context)!.noteSavedSuccess),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
