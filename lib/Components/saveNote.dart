import 'package:flutter/material.dart';
import 'textnoteservice.dart';
import 'package:untitled3/Services/textnoteservice.dart';
import 'package:untitled3/Screens/Bottom_bar.dart';
import 'package:untitled3/Screens/Setting.dart';

final saveNoteScaffoldKey = GlobalKey<ScaffoldState>();

/// Save Note page
class SaveNote extends StatefulWidget {

  @override
  SaveNoteState createState() => SaveNoteState();
}

class SaveNoteState extends State<SaveNote> {
  /// Text note service to use for I/O operations against local system
  final TextNoteService textNoteService = new TextNoteService();

  final textController = TextEditingController();

  SaveNoteState();

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: saveNoteScaffoldKey,
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Colors.white,
              size: 35,
            )),
        toolbarHeight: 90,
        title: Text('Save a note',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 30,
                color: Colors.black)),
        backgroundColor: Color(0xFF33ACE3),
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.event_note_sharp,
                    color: Colors.white,
                    size: 35,
                  ))
            ],
          )
        ],
      ),
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
                    textNoteService.saveTextFile(textController.text, false);
                    showConfirmDialog(context);
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
        Navigator.pushNamed(context, '/view-notes');
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
