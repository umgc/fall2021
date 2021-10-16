import 'dart:convert';
import 'dart:ui';

enum FontSize {
   SMALL,
   MEDIUM,
   LARGE,
}

enum AppTheme {
  BLUE,
  PINK
}

fontSizeStringToEnum (String fontSizeString) {
  switch (fontSizeString) {
    case 'FontSize.MEDIUM':
      return FontSize.MEDIUM;
    case 'FontSize.SMALL':
      return FontSize.SMALL;
    case 'FontSize.LARGE':
      return FontSize.LARGE;
  }
}

appThemeStringToEnum (String appTheme) {
  switch (appTheme) {
    case 'BLUE':
      return AppTheme.BLUE;
    case 'PINK':
      return AppTheme.PINK;
    default:
      return AppTheme.BLUE;
  }
}

const DEFAULT_FONT_SIZE = FontSize.MEDIUM;

const DEFAULT_DAYS_TO_KEEP_FILES = "7";

const DEFAULT_LOCALE = const Locale("en", "US");

const DEFAULT_APP_THEME = AppTheme.BLUE;

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
  Locale locale = DEFAULT_LOCALE;

  /// path to the wake word file
  bool enableVoiceOverText = false;

  FontSize noteFontSize = DEFAULT_FONT_SIZE;
  FontSize menuFontSize = DEFAULT_FONT_SIZE;

  AppTheme appTheme = DEFAULT_APP_THEME;

  /// Constructor takes all properties as params
  Setting();

  String toJson() {
    String jsonStr = """{"daysToKeepFiles": "${this.daysToKeepFiles}",
                        "secondsSilence": "${this.secondsSilence}",
                        "pathToWakeWord": "${this.pathToWakeWord}",
                        "locale": "${this.locale.toString()}",
                        "isFirstRun": ${this.isFirstRun},
                        "enableVoiceOverText": ${this.enableVoiceOverText},
                        "appTheme": "${this.appTheme.toString()}",
                        "noteFontSize": "${this.noteFontSize.toString()}",
                        "menuFontSize": "${this.noteFontSize.toString()}" }
                        """;
    
    return jsonStr;

  }

  factory Setting.fromJson(dynamic jsonObj) {
    Setting setting = Setting();
    print("extracting jsonObj $jsonObj");
    if (jsonObj != "") {
      setting.daysToKeepFiles =
          jsonObj['daysToKeepFiles'].toString();
      setting.secondsSilence = jsonObj['secondsSilence'];
      setting.pathToWakeWord = jsonObj['pathToWakeWord'];
      setting.locale = Locale(jsonObj['locale']);
      setting.isFirstRun = jsonObj['isFirstRun'];
      setting.enableVoiceOverText = jsonObj['enableVoiceOverText'];
      setting.noteFontSize = fontSizeStringToEnum(jsonObj['noteFontSize']);
      setting.menuFontSize = fontSizeStringToEnum(jsonObj['menuFontSize']);
      setting.appTheme = appThemeStringToEnum(jsonObj['appTheme']);

    }

    return setting;
  }

  @override
  String toString() {
    return this.toJson();
  }
}
