/// Defines the settings object
class Setting {
  /// days to keep files before clearing them
  String daysToKeepFiles;

  /// seconds to listen before stopping a recording
  String secondsSilence;

  /// path to the wake word file
  String pathToWakeWord;

  /// Constructor takes all properties as params
  Setting(this.daysToKeepFiles, this.secondsSilence, this.pathToWakeWord);
}