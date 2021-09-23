import 'dart:ui';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SCREEN_NAMES {
   static final String MENU = "MENU";
   static final String SAVE_NOTE = "SAVE_NOTE";
   static final String NOTE = "NOTE";
   static final String HOME = "HOME";
   static final String NOTIFICATION = "NOTIFICATION";
   static final String SETTING = "SETTING";
   static final String CALENDAR = "CALENDAR";
 }

 const SUPPORTED_LOCALES = [Locale('en', 'US'), Locale('es', 'US')];

const LOCALIZATION_DELEGATES = [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,
       GlobalCupertinoLocalizations.delegate,
];