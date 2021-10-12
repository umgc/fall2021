import 'dart:convert';
import 'dart:ui';

enum FontSize {
   SMALL,
   MEDIUM,
   LARGE,
}

const DEFAULT_FONT_SIZE = FontSize.MEDIUM;

const DEFAULT_DAYS_TO_KEEP_FILES = "7";

const DEFAULT_LOCALE = const Locale("en", "US");

/// Defines the settings object
class Setting {
  /// days to keep files before clearing them
  String daysToKeepFiles = DEFAULT_DAYS_TO_KEEP_FILES;

  /// seconds to listen before stopping a recording
  String secondsSilence = "Yes";

  /// path to the wake word file
  String pathToWakeWord = "path";

  //bool to track if the app is newly intalled
  bool isFirstRun = true;

  // language of preference
  String currentLanguage = "English";

  Locale locale = DEFAULT_LOCALE;

  /// path to the wake word file
  bool enableVoiceOverText = false;

  FontSize noteFontSize = DEFAULT_FONT_SIZE;
  FontSize menuFontSize = DEFAULT_FONT_SIZE;

  /// Constructor takes all properties as params
  Setting();

  String toJson() {
    String jsonStr = """{"daysToKeepFiles": "${this.daysToKeepFiles}",
                        "secondsSilence": "${this.secondsSilence}",
                        "pathToWakeWord": "${this.pathToWakeWord}",
                        "locale": "${this.locale.toString()}",
                        "currentLanguage": "${this.currentLanguage}",
                        "isFirstRun": ${this.isFirstRun},
                        "enableVoiceOverText": ${this.enableVoiceOverText},
                        "noteFontSize": ${json.encode(this.noteFontSize)},
                        "menuFontSize": ${json.encode(this.menuFontSize)} }
                        """;
    
    return jsonStr;

  }

  factory Setting.fromJson(dynamic jsonObj) {
    Setting setting = Setting();
    print("extracting jsonObj $jsonObj");
    if (jsonObj != "") {
      setting.daysToKeepFiles =
          jsonObj['daysToKeepFiles'] ?? DEFAULT_DAYS_TO_KEEP_FILES;
      setting.secondsSilence = jsonObj['secondsSilence'];
      setting.pathToWakeWord = jsonObj['pathToWakeWord'];
      setting.currentLanguage = jsonObj['currentLanguage'];
      setting.locale = Locale(jsonObj['locale']);
      setting.isFirstRun = jsonObj['isFirstRun'];
      setting.enableVoiceOverText = jsonObj['enableVoiceOverText'];
      setting.noteFontSize = FontSize.values[json.decode(jsonObj['noteFontSize'])];
      setting.menuFontSize =  FontSize.values[json.decode(jsonObj['menuFontSize'])];
    }

    return setting;
  }

  @override
  String toString() {
    return this.toJson();
  }
}
