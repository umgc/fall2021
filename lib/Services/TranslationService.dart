import 'dart:ui';
import 'package:translator/translator.dart';

class TranslationService {
  /// Constructor
  TranslationService();

  static Future translate({
    required String textToTranslate,
    required GoogleTranslator translator,
    Locale fromLocale = const Locale("en", "US"),
    Locale toLocale = const Locale("en", "US"),
  }) async {
    var translation = await translator.translate(textToTranslate,
        from: fromLocale.languageCode, to: toLocale.languageCode);
    return translation.toString();
    // return new TranslatedTextNote();
    // const TranslatedNote = new TranslatedNote();
    // return Google.tranlate(string, locale);
    // speaks out loud and returns the promise that gives await speakOutLoud().then()
  }

/*  // this method will take a Note and turn its locale from a string ex "en-us" into a Locale("es", "US")
  static Locale getLocaleFromNote(Note note) {

  }*/

}
