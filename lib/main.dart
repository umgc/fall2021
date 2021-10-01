// Official
import 'package:flutter/material.dart';
// Internal
import 'package:untitled3/Screens/Note/Note.dart';
import 'package:untitled3/Screens/Note/NoteDetail.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled3/Model/Setting.dart';
import 'package:untitled3/Services/SettingService.dart';
import 'generated/i18n.dart';
import 'Screens/Main.dart';
import 'package:provider/provider.dart';


import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) { 
    SettingService.save(Setting());
    
    final i18n = I18n.delegate;
    return MultiProvider(
        providers: [
          Provider<MenuObserver>(create: (_) => MenuObserver()),
          Provider<NoteObserver>(create: (_) => NoteObserver()),
          Provider<MainNavObserver>(create: (_) => MainNavObserver()),
          Provider<SettingObserver>(create: (_) => SettingObserver()),
        ],
      child: (MaterialApp(
      debugShowCheckedModeBanner: false,
      home:MainNavigator(),
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
    )
    )
    );
  }
}
