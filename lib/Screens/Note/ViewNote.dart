import 'package:flutter/material.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:provider/provider.dart';
import 'package:untitled3/Services/NoteService.dart';
import 'package:untitled3/Utility/Constant.dart';
import 'package:untitled3/generated/i18n.dart';
import '../../Observables/NoteObservable.dart';

final viewNotesScaffoldKey = GlobalKey<ScaffoldState>();

/// View Notes page
class ViewNotes extends StatefulWidget {
  @override
  _ViewNotesState createState() => _ViewNotesState();
}

class _ViewNotesState extends State<ViewNotes> {
  _ViewNotesState();

  @override
  Widget build(BuildContext context) {
    // String noteDetailScreen =I18n.of(context)!.notesDetailScreenName;
    // String addNoteScreen =I18n.of(context)!.addNotesScreenName;
    // String noteScreen =I18n.of(context)!.notesScreenName;

    final noteObserver = Provider.of<NoteObserver>(context);
    noteObserver.resetCurrNoteIdForDetails();

    final TEXT_STYLE = TextStyle(fontSize: 20);
    const HEADER_TEXT_STYLE = const TextStyle(fontSize: 20);

    var rowHeight = (MediaQuery.of(context).size.height - 56) / 5;
    var noteWidth = MediaQuery.of(context).size.width * 0.35;
    print("My width is $noteWidth");

    //noteObserver.changeScreen(NOTE_SCREENS.NOTE);
    return Scaffold(
        body: SingleChildScrollView(
            child: DataTable(
                dataRowHeight: rowHeight,
                headingRowHeight: 60,
                columns: const <DataColumn>[
                  DataColumn(
                    label: Text(
                      '',
                      style: HEADER_TEXT_STYLE,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'NOTE',
                      style: HEADER_TEXT_STYLE,
                    ),
                  ),
                  DataColumn(
                    label: Text(
                      'CREATED',
                      style: HEADER_TEXT_STYLE,
                    ),
                  ),
                ],
                rows: List<DataRow>.generate(
                  noteObserver.usersNotes.length,
                  (int index) => DataRow(
                    cells: <DataCell>[
                      DataCell(Text("${(index + 1)}")),
                      DataCell(
                        Container(
                            padding: EdgeInsets.all(10),
                            width: noteWidth,
                            child: Text(
                              noteObserver.usersNotes[index].text,
                              style: TEXT_STYLE,
                            )),
                        showEditIcon: true,
                        onTap: () => {
                          print(noteObserver.usersNotes[index].noteId),
                          noteObserver
                              .setCurrNoteIdForDetails(
                                  noteObserver.usersNotes[index].noteId)
                              .then((value) => noteObserver
                                  .changeScreen(NOTE_SCREENS.NOTE_DETAIL))
                        },
                      ),
                      DataCell(Text(timeago.format(
                          noteObserver.usersNotes[index].recordedTime))),
                    ],
                  ),
                ))),
        floatingActionButton: buildFloatingBtn(noteObserver));
  }

  //Funtion retuns Floating button
  Widget buildFloatingBtn(NoteObserver noteObserver) {
    return FloatingActionButton(
      onPressed: () {
        noteObserver.changeScreen(NOTE_SCREENS.ADD_NOTE);
      },
      tooltip: I18n.of(context)!.addNote,
      child: Icon(Icons.add),
    );
  }
}
