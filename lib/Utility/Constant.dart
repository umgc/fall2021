import 'dart:ui';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

 const SUPPORTED_LOCALES = [Locale('en', 'US'), Locale('es', 'US')];

const LOCALIZATION_DELEGATES = [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
       GlobalWidgetsLocalizations.delegate,
       GlobalCupertinoLocalizations.delegate,
];