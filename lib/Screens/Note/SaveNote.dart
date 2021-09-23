import 'package:flutter/material.dart';
import 'package:untitled3/Services/NoteService.dart';
import 'package:untitled3/Screens/Setting.dart';
import '../../Observables/NoteObservable.dart';
import '../../Utility/Constant.dart';

final saveNoteScaffoldKey = GlobalKey<ScaffoldState>();

/// Save Note page
class SaveNote extends StatefulWidget {
  
  var navScreenObs;

  SaveNote(navScreenObs){
    this.navScreenObs = navScreenObs;
  }

  @override
  State<SaveNote> createState() => _SaveNoteState(navScreenObs);
}

class _SaveNoteState extends State<SaveNote> {
  /// Text note service to use for I/O operations against local system
  final TextNoteService textNoteService = new TextNoteService();

  final textController = TextEditingController();
  var navScreenObs; 

  _SaveNoteState( NoteScreenNav navScreenObs ){
    this.navScreenObs = navScreenObs;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: saveNoteScaffoldKey,
      body: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              TextField(
                controller: textController,
                maxLines: 5,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: 'Enter your note\'s text'),
              ),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.deepPurple),
                  overlayColor: MaterialStateProperty.all<Color>(
                      Colors.deepPurple.shade300),
                ),
                onPressed: () {
                  if (textController.text.length > 0) {
                    //textNoteService.saveTextFile(textController.text, false);
                    //showConfirmDialog(context); there should be a "Note Save" toast instead
                    navScreenObs.changeScreen(SCREEN_NAMES.NOTE);
                  }
                },
                child: Text('Save'),
              ),
            ],
          )),
      //bottomNavigationBar: BottomBar(3),
    );
  }

  /// Show a dialog message confirming note was saved
  showConfirmDialog(BuildContext context) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        navScreenObs.changeScreen(SCREEN_NAMES.NOTE);
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
