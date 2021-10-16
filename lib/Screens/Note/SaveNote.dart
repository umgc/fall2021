import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Services/NoteService.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import '../../Observables/NoteObservable.dart';

final saveNoteScaffoldKey = GlobalKey<ScaffoldState>();

/// Save Note page
class SaveNote extends StatefulWidget {
  SaveNote() {}

  @override
  State<SaveNote> createState() => _SaveNoteState();
}

class _SaveNoteState extends State<SaveNote> {
  /// Text note service to use for I/O operations against local system
  final TextNoteService textNoteService = new TextNoteService();

  final textController = TextEditingController();

  _SaveNoteState() {
    //this.navScreenObs = navScreenObs;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  bool isChecked = false;

  void _showToast() {
    Fluttertoast.showToast(
        msg: 'NOTE SAVED',
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        timeInSecForIosWeb: 4);
  }

  //ref: https://api.flutter.dev/flutter/material/Checkbox-class.html
  Widget _checkBox() {
    Color getColor(Set<MaterialState> states) {
      return Colors.blue;
    }

    return Row(
      children: [
        Text("Is a Daily Checklist item"),
        Checkbox(
          checkColor: Colors.white,
          fillColor: MaterialStateProperty.resolveWith(getColor),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        )
      ],
    );
  }

  //ref: https://pub.dev/packages/date_time_picker
  Widget _selectDate() {
    return DateTimePicker(
      type: DateTimePickerType.dateTimeSeparate,
      dateMask: 'd MMM, yyyy',
      initialValue: DateTime.now().toString(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      icon: Icon(Icons.event),
      dateLabelText: 'Date',
      timeLabelText: "Hour",
      selectableDayPredicate: (date) {
        return true;
      },
      onChanged: (val) => print(val),
      validator: (val) {
        print(val);
        return null;
      },
      onSaved: (val) => print(val),
    );
  }

  Widget _button(Color background, String text, Function callbackFn) {
    var btnSize = MediaQuery.of(context).size.width * 0.9;
    return TextButton(
      style: ButtonStyle(
          foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
          backgroundColor: MaterialStateProperty.all<Color>(background),
          overlayColor: MaterialStateProperty.all<Color>(Colors.grey.shade300),
          fixedSize: MaterialStateProperty.all<Size>(Size.fromWidth(btnSize))),
      onPressed: () => {callbackFn.call()},
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    final noteObserver = Provider.of<NoteObserver>(context);

    var padding = MediaQuery.of(context).size.width * 0.02;
    var spaceBetweenBtn = MediaQuery.of(context).size.width * 0.5;

    var verticalColSpace = MediaQuery.of(context).size.width * 0.1;

    return Scaffold(
      key: saveNoteScaffoldKey,
      body: Container(
          padding: EdgeInsets.all(padding),
          child: Column(
            children: [
              TextField(
                controller: textController,
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your note\'s text'),
              ),
              SizedBox(height: verticalColSpace),
              _checkBox(),
              SizedBox(height: verticalColSpace),
              _selectDate(),
              SizedBox(height: verticalColSpace),
              _button(Color(0xFF33ACE3), "SAVE", () => {_onSave(noteObserver)}),
              _button(Colors.red.shade400, "CANCEL",
                  () => {noteObserver.changeScreen(NOTE_SCREENS.NOTE)}),
            ],
          )),
      //bottomNavigationBar: BottomBar(3),
    );
  }

  _onSave(noteObserver) {
    if (textController.text.length > 0) {
      TextNote note = TextNote();
      note.text = textController.text;
      noteObserver.addNote(note);
      _showToast();
      noteObserver.changeScreen(NOTE_SCREENS.NOTE);
    }
  }

  /// Show a dialog message confirming note was saved
  showConfirmDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        //navScreenObs.changeScreen(SCREEN_NAMES.NOTE);
      },
    );

    // set up the dialog
    AlertDialog alert = AlertDialog(
      content: Text("The text note was saved successfully."),
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
