/// Defines the settings object
class Setting {
  /// days to keep files before clearing them
  String daysToKeepFiles = "7";

  /// seconds to listen before stopping a recording
  String secondsSilence= "Yes";

  /// path to the wake word file
  String pathToWakeWord ="path";

  //bool to track if the app is newly intalled
  bool isFirstRun=true;

  // language of preference
  String currentLanguage ="English";

  /// path to the wake word file
  bool enableVoiceOverText=false;

  /// Constructor takes all properties as params
  Setting();

  String toJson() {
    String jsonStr = """{"daysToKeepFiles": "${this.daysToKeepFiles}",
                        "secondsSilence": "${this.secondsSilence}",
                        "pathToWakeWord": "${this.pathToWakeWord}",
                        "currentLanguage": "${this.currentLanguage}",
                        "isFirstRun": ${this.isFirstRun},
                        "enableVoiceOverText": ${this.enableVoiceOverText}}
                        """;

    return jsonStr;
  }


  factory Setting.fromJson(dynamic jsonObj) {
    Setting setting = Setting();
    print("extracting jsonObj $jsonObj");
    setting.daysToKeepFiles = jsonObj['daysToKeepFiles'];
    setting.secondsSilence = jsonObj['secondsSilence'];
    setting.pathToWakeWord = jsonObj['pathToWakeWord'];
    setting.currentLanguage = jsonObj['currentLanguage'];
    setting.isFirstRun = jsonObj['isFirstRun'];
    setting.enableVoiceOverText = jsonObj['enableVoiceOverText'];

    return setting;
  }

  @override
  String toString(){
      return this.toJson();
  }

}