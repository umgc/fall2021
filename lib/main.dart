// Official
import 'package:flutter/material.dart';
// Internal
import 'package:untitled3/Screens/Note/Note.dart';
import 'package:untitled3/Screens/Note/NoteDetail.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'generated/i18n.dart';
import 'Screens/Main.dart';

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
        '/view-notes': (context) => ViewNotes(),
        '/note-details': (context) => NoteDetails()
      },
    );
  }
}
