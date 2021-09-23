// Official
import 'package:flutter/material.dart';
import 'package:untitled3/Model/Note.dart';
import 'dart:developer';

// Internal
import 'package:untitled3/Screens/Setting.dart';
import 'package:untitled3/Screens/Note/SaveNote.dart';
import 'package:untitled3/Screens/Note/Note.dart';
import 'package:untitled3/Screens/Note/NoteDetail.dart';

import 'Screens/Main.dart';
import 'Utility/Constant.dart';
import 'Utility/FileUtil.dart';
import 'Services/NoteService.dart';
import 'Observables/NoteObservable.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  String payload = """[{"noteId": "noteId","recordLocale": "Item1","recordedTime": "2012-04-23T18:25:43.511Z","preferredLocale": "usa","isCheckList": false,"isEvent": false,"text": "text","isFavorite": false	}]""";
  //String payload = """{"notes": [{"id": "p1","name": "Item 1","description": "Description 1"},{"id": "p2","name": "Item 2","description": "Description 2"},{"id": "p3","name": "Item 3","description": "Description 3"}]}""";

//   String payload = """{
// 	"notes": [{
// 		"id": "p1",
// 		"name": "Item 1",
// 		"description": "Description 1"
// 	}, {
// 		"id": "p2",
// 		"name": "Item 2",
// 		"description": "Description 2"
// 	}, {
// 		"id": "p3",
// 		"name": "Item 3",
// 		"description": "Description 3"
// 	}]
// }""";
  @override
  Widget build(BuildContext context) {
    
    NoteScreenNav observe = NoteScreenNav();
    //TextNoteService().add(payload);
    observe.addNote(TextNote());

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Observer(
              builder: (_) => Scaffold(
                  body: Center(
                    child: Text("${ observe.usersNotes.length> 0? 
                                    observe.usersNotes[0].recordedTime
                                    : "" }"),
                  )
              )
          ), //MainNavigator(),
      localizationsDelegates: LOCALIZATION_DELEGATES,
      supportedLocales: SUPPORTED_LOCALES,
      routes: {
        '/view-notes': (context) => ViewNotes(),
        '/note-details': (context) => NoteDetails()
      },
    );
  }
}
