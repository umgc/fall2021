import 'dart:ui';
import 'package:flutter_localizations/flutter_localizations.dart';

class SCREEN_NAMES {
  static final String MENU = "MENU";
  static final String SAVE_NOTE = "SAVE_NOTE";
  static final String NOTE = "NOTE";
  static final String HOME = "HOME";
  static final String NOTIFICATION = "NOTIFICATION";
  static final String SETTING = "SETTING";
  static final String CALENDAR = "CALENDAR";
  static final String NOTE_DETAIL = "NOTE_DETAIL";
}

const SUPPORTED_LOCALES = [Locale('en', 'US'), Locale('es', 'US')];

const LOCALIZATION_DELEGATES = [
  GlobalMaterialLocalizations.delegate,
  GlobalWidgetsLocalizations.delegate,
  GlobalCupertinoLocalizations.delegate,
];
