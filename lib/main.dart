// Official
import 'package:flutter/material.dart';

// Internal
import 'package:untitled3/Screens/Setting.dart';
import 'package:untitled3/Components/saveNote.dart';
import 'package:untitled3/Screens/Note.dart';
import 'package:untitled3/Components/notedetails.dart';

import 'Screens/Main.dart';
import 'Utility/Constant.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigator(),
      localizationsDelegates: LOCALIZATION_DELEGATES,
      supportedLocales: SUPPORTED_LOCALES,
      routes: {
        '/save-note': (context) => SaveNote(),
        '/view-notes': (context) => ViewNotes(),
        '/note-details': (context) => NoteDetails(),
        '/Setting': (context) => Setting(),
      },
    );
  }
}
