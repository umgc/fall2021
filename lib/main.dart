// Official
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:untitled3/Observables/MicObservable.dart';
import 'package:untitled3/Observables/OnboardObservable.dart';
// Internal
import 'package:untitled3/Screens/Note/Note.dart';
import 'package:untitled3/Screens/Note/NoteDetail.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:untitled3/Screens/Onboarding/Boarding.dart';

import 'generated/i18n.dart';
import 'Screens/Main.dart';
import 'package:provider/provider.dart';

import 'package:untitled3/Observables/MenuObservable.dart';
import 'package:untitled3/Observables/SettingObservable.dart';
import 'package:untitled3/Observables/NoteObservable.dart';
import 'package:untitled3/Observables/ScreenNavigator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    I18n.onLocaleChanged = onLocaleChange;
  }

  void onLocaleChange(Locale locale) {
    setState(() {
      I18n.locale = locale;
    });
  }

  @override
  Widget build(BuildContext context) {
    SettingObserver settingObserver = SettingObserver();
    
    final i18n = I18n.delegate;
    return MultiProvider(
        providers: [
          Provider<OnboardObserver>(create: (_) => OnboardObserver()),
          Provider<MenuObserver>(create: (_) => MenuObserver()),
          Provider<NoteObserver>(create: (_) => NoteObserver()),
          Provider<MainNavObserver>(create: (_) => MainNavObserver()),
          Provider<SettingObserver>(create: (_) => SettingObserver()),
          Provider<MicObserver>(create: (_) => MicObserver()),
        ],
        child: (MaterialApp(
          debugShowCheckedModeBanner: false,
          home:  Observer(
         builder: (_) => (settingObserver.userSettings.isFirstRun == false)
        ? MainNavigator()
        : OnBoardingScreen()),



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
            '/note-details': (context) => NoteDetails()
          },
        )));
  }
}
