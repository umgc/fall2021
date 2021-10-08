import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Services/NoteService.dart';
import 'package:untitled3/generated/i18n.dart';

class NoteDetails extends StatefulWidget {
  NoteDetails({
    Key? key,
  }) : super(key: key);

  //route set here to allow for arguments to be passed - Alec
  static const routeName = '/note-details';

  @override
  State<NoteDetails> createState() => _NoteDetailssState();
}

class _NoteDetailssState extends State<NoteDetails> {

  final editController = TextEditingController();

  static final dateFormat = new DateFormat('EEE, MMM d, yyyy\nh:mm a');

  /// Text note service to use for I/O operations against local system
  final TextNoteService textNoteService = new TextNoteService();


  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    editController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    
    final noteObserver = Provider.of<NoteObserver>(context);
    editController.text = noteObserver.currNoteForDetails!.text;
    editController.addListener( ()=> noteObserver.currNoteForDetails!.text = ('${editController.text}'));

    return Observer(
             builder: (_) => Scaffold(
              
            body: 
              (noteObserver.currNoteForDetails == null)?
                  Text("Loading...")
              : ListView(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                    ),
                    child: IntrinsicHeight(
                      //row with 3 spaced columns
                      child: Row(
                        children: <Widget>[
                          //date column
                          Column(
                            children: <Widget>[
                              Container(
                                margin: const EdgeInsets.only(
                                  top: 10,
                                ),
                                child: Center(
                                  child: Text(
                                    //passed date String should display here - Alec
                                    dateFormat.format(noteObserver.currNoteForDetails!.recordedTime),

                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Spacer(flex: 1),
                          //edit icon
                          Column(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () async {
                                  
                                  /*
                                  TODO: Update function 
                                  textNoteService.updateTextFile(new TextNote(
                                      selectedNote.data.fileName,
                                      selectedNote.data.dateTime,
                                      edits,
                                      false));*/

                                  //Navigator.pushNamed(context, '/view-notes');
                                },
                                child: Icon(
                                  Icons.save,
                                  color: Colors.black,
                                  size: 50.0,
                                  semanticLabel: 'Edit Note',
                                ),
                              ),
                            ],
                          ),
                          Spacer(flex: 1),
                          //delete icon
                          Column(
                            children: <Widget>[
                              ElevatedButton(
                                onPressed: () async {
                                  showAlertDialog(context, noteObserver);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                  size: 50.0,
                                  semanticLabel: 'Delete Note',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    //text field should enable when user selects edit icon
                    padding: EdgeInsets.all(30.0),
                    child: TextField(
                      //this is where the note text displays see editController - Alec
                      controller: editController,
                      enabled: true,
                      focusNode: FocusNode(),
                      enableInteractiveSelection: true,
                      maxLines: null,
                      style: TextStyle(
                        fontSize: 20.0,
                      ),
                    ),
                  ),
                ],
              ),
            )
      );
  }

//This alert dialog runs when Delete buttion is selected
  showAlertDialog(BuildContext context, NoteObserver noteObserver) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        //closes popup
        Navigator.of(context).pop();
      },
    );
    Widget confirmButton = TextButton(
      child: Text(
        "Confirm",
        style: TextStyle(fontSize: 20),
      ),
      onPressed: () {
        noteObserver.deleteNote(noteObserver.currNoteForDetails);
        noteObserver.changeScreen(I18n.of(context)!.notesScreenName);
        Navigator.of(context).pop();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Confirm Note Deletion",
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
      ),
      content: Text(
        "Are you sure you want to delete this note?",
        style: TextStyle(fontSize: 20),
      ),
      actions: [
        cancelButton,
        confirmButton,
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