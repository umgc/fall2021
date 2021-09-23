// Official
import 'package:flutter/material.dart';

// Internal
import 'package:untitled3/Screens/Setting.dart';
import 'package:untitled3/Components/saveNote.dart';
import 'package:untitled3/Screens/Note.dart';
import 'package:untitled3/Components/notedetails.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'Screens/Main.dart';
import 'generated/i18n.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final i18n = I18n.delegate;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MainNavigator(),
      localizationsDelegates: [
        i18n,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: i18n.supportedLocales,
      localeResolutionCallback:
          i18n.resolution(fallback: new Locale("en", "US")),
      routes: {
        '/save-note': (context) => SaveNote(),
        '/view-notes': (context) => ViewNotes(),
        '/note-details': (context) => NoteDetails(),
        '/Setting': (context) => Setting(),
      },
    );
  }
}
