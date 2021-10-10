import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:untitled3/Screens/Note/NoteDetail.dart';
import 'package:untitled3/generated/i18n.dart';
import '../../Observables/NoteObservable.dart';
import 'SaveNote.dart';
import '../../Model/Note.dart';

final viewNotesScaffoldKey = GlobalKey<ScaffoldState>();

/// View Notes page
class ViewNotes extends StatefulWidget {
  @override
  _ViewNotesState createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  _ViewNotesState();
  // text to speech
  // FlutterTts flutterTts = FlutterTts();

  // Future readFilterResults() async {
  //   List<TextNote> textNotes = [];//await textNoteService.getTextFileList(searchFilter);
  //   if (textNotes.isNotEmpty) {
  //     if (readResults) {
  //       for (TextNote note in textNotes) {
  //         readResults = false;
  //         await flutterTts.speak("Your reminders for " +
  //             searchFilter +
  //             " are: " +
  //             note.text.toString());
  //       }
  //     }
  //   }
  // }

//Funtion retuns Floating button
  Widget buildFloatingBtn() {
    final noteObserver = Provider.of<NoteObserver>(context);
    String addNoteScreen = I18n.of(context)!.addNotesScreenName;

    return FloatingActionButton(
      onPressed: () {
        noteObserver.changeScreen(addNoteScreen);
      },
      tooltip: I18n.of(context)!.saveNote,
      child: Icon(Icons.add),
    );
  }

  @override
  Widget build(BuildContext context) {
    String noteDetailScreen = I18n.of(context)!.notesDetailScreenName;
    String addNoteScreen = I18n.of(context)!.addNotesScreenName;
    String noteScreen = I18n.of(context)!.notesScreenName;

    final noteObserver = Provider.of<NoteObserver>(context);
    noteObserver.changeScreen(noteScreen);

    return Observer(
        builder: (_) => (noteObserver.currentScreen == noteScreen &&
                noteObserver.usersNotes.length > 0)
            ? Scaffold(
                //appBar: buildAppBar(context),
                key: viewNotesScaffoldKey,
                body: SingleChildScrollView(
                  child: Table(
                      border: TableBorder.all(),
                      columnWidths: const <int, TableColumnWidth>{
                        0: FlexColumnWidth(.45),
                        1: FlexColumnWidth(),
                        2: FlexColumnWidth()
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(
                            decoration:
                                const BoxDecoration(color: Colors.blueGrey),
                            children: <Widget>[
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text('ID',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white))),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        I18n.of(context)!.date.toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white))),
                              ),
                              TableCell(
                                verticalAlignment:
                                    TableCellVerticalAlignment.top,
                                child: Container(
                                    padding: EdgeInsets.all(10),
                                    child: Text(
                                        I18n.of(context)!.note.toUpperCase(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                            color: Colors.white))),
                              ),
                            ]),
                        //not sure how to pass the correct element
                        for (TextNote textNote in noteObserver.usersNotes)
                          TableRow(children: <Widget>[
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(textNote.noteId,
                                      style: TextStyle(fontSize: 20))),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              child: Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                      timeago.format(textNote.recordedTime),
                                      style: TextStyle(fontSize: 20))),
                            ),
                            TableCell(
                              verticalAlignment: TableCellVerticalAlignment.top,
                              // text button used to test exact solution from
                              // https://flutter.dev/docs/cookbook/navigation/navigate-with-arguments
                              // - Alec

                              child: GestureDetector(
                                  onTap: () {
                                    //noteObserver.changeScreen(addNoteScreen);
                                  },
                                  child: TextButton(
                                    onPressed: () {
                                      //set the target note for which we want to display details
                                      noteObserver.setCurrNoteIdForDetails(
                                          textNote.noteId);
                                      //navigate to the note details screen
                                      noteObserver
                                          .changeScreen(noteDetailScreen);
                                    },
                                    child: Container(
                                        padding: EdgeInsets.all(10),
                                        child: Text(textNote.text,
                                            style: TextStyle(
                                              fontSize: 20,
                                            ))),
                                  )),
                            ),
                          ]),
                      ]),
                ),
                // Add table rows for each text note

                floatingActionButton: buildFloatingBtn())
            : (noteObserver.currentScreen == addNoteScreen)
                ? SaveNote()
                : (noteObserver.currentScreen == noteDetailScreen)
                    ? NoteDetails()
                    : Scaffold(
                        body: Text("Oops you have not notes."),
                        floatingActionButton: buildFloatingBtn()));
  }
}
