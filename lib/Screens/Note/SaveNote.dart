import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Model/Note.dart';
import 'package:untitled3/Services/NoteService.dart';
import '../../Observables/NoteObservable.dart';
import '../../Utility/Constant.dart';


final saveNoteScaffoldKey = GlobalKey<ScaffoldState>();

/// Save Note page
class SaveNote extends StatefulWidget {
  

  SaveNote(){
  }

  @override
  State<SaveNote> createState() => _SaveNoteState();
}

class _SaveNoteState extends State<SaveNote> {
  /// Text note service to use for I/O operations against local system
  final TextNoteService textNoteService = new TextNoteService();

  final textController = TextEditingController();
   
  _SaveNoteState(){
    //this.navScreenObs = navScreenObs;
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }


  void showToast() {  
    Fluttertoast.showToast(  
        msg: 'NOTE SAVED',  
        toastLength: Toast.LENGTH_LONG,  
        gravity: ToastGravity.BOTTOM,  
        backgroundColor: Colors.green,  
        textColor: Colors.white,
        timeInSecForIosWeb: 4
    );  
  }

  @override
  Widget build(BuildContext context) {

    final noteObserver = Provider.of<NoteObserver>(context);


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

                    TextNote note = TextNote();
                    note.text = textController.text;
                    noteObserver.addNote(note);
                    showToast();
                    noteObserver.changeScreen(SCREEN_NAMES.NOTE);
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
