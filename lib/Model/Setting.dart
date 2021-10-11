enum FontSize {
  SMALL,
  MEDIUM,
  LARGE,
}

extension ParseFontSizeToDisplay on FontSize {
  String toShortString() {
    return this.toString().split('.').last;
  }
}

const DEFAULT_FONT_SIZE = FontSize.MEDIUM;

const DEFAULT_DAYS_TO_KEEP_FILES = "7";

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
                        "currentLanguage": "${this.currentLanguage}",
                        "isFirstRun": ${this.isFirstRun},
                        "enableVoiceOverText": ${this.enableVoiceOverText},
                        "noteFontSize": ${this.noteFontSize.toString()},
                        "menuFontSize": ${this.menuFontSize.toString()}}
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
      setting.isFirstRun = jsonObj['isFirstRun'];
      setting.enableVoiceOverText = jsonObj['enableVoiceOverText'];
      setting.noteFontSize = jsonObj['noteFontSize'] ?? DEFAULT_FONT_SIZE;
      setting.menuFontSize = jsonObj['menuFontSize'] ?? DEFAULT_FONT_SIZE;
    }

    return setting;
  }

  @override
  String toString() {
    return this.toJson();
  }
}
