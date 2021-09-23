import 'package:path_provider/path_provider.dart';
import 'package:xml/xml.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';
import '../Model/Note.dart';
import '../Utility/EncryptionUtil.dart';

/// Encapsulates all file I/O for text notes
class SettingService {

  String FILE_NAME = "memory_notes.json";

  /// Maximum length for teaser excerpt from text note, shown in View Notes list
  static final teaserLength = 100;

  /// The file system to use for all I/O operations. Generally LocalFileSystem()
  /// but MemoryFileSystem() is used when running unit tests.
  static FileSystem fileSystem = const LocalFileSystem();

  /// Constructor
  SettingService();

  /// Returns the correct file directory for all text notes
  Future<Directory> _getTextNotesDirectory() async {
    var docsDirectory = fileSystem.directory(".");

    try {
      if (fileSystem is LocalFileSystem) {
        // Docs folder only available for Android and IOS, not unit tests
        var docsPath = (await getApplicationDocumentsDirectory()).path;
        docsDirectory = fileSystem.directory(docsPath);

        final notesDirectory =
        fileSystem.directory('${docsDirectory.path}/Memory_Magic');
        notesDirectory.createSync();
        return notesDirectory;
      }
    } catch (MissingPluginException) {}

    return docsDirectory;
  }


  /// Update the settings file to local storage
  updateSettings(Setting updatedSettings) async {
    try {
      var textNotesDirectory = await _getTextNotesDirectory();
      var fileName = "settings";
      final File file = fileSystem.file('${textNotesDirectory.path}/$fileName');

      String settingsXml = '''<?xml version="1.0"?>
        <settings>
          <file-name>$fileName</file-name>
          <days-to-keep>${updatedSettings.daysToKeepFiles}</days-to-keep>        
          <seconds-to-wait>${updatedSettings.secondsSilence}</seconds-to-wait>
          <path-to-wake-word>${updatedSettings.pathToWakeWord}</path-to-wake-word>
        </settings>''';

      final encryptedNote = EncryptUtil.encryptNote(settingsXml);
      await file.writeAsString(encryptedNote);
      print("File saved: ${file.path}");
    } catch (e) {
      print("ERROR-Couldn't update file: ${e.toString()}");
    }
  }


  /// Returns the app settings
  Future<Setting> getSettings() async {
    try {
      String fileName = 'settings';
      var textNotesDirectory = await _getTextNotesDirectory();
      final File file = fileSystem.file('${textNotesDirectory.path}/$fileName');
      String fileText = file.readAsStringSync();

      final decryptedNote = EncryptUtil.decryptNote(fileText);
      final document = XmlDocument.parse(decryptedNote);

      print("File retrieved: ${file.path}");

      String daysToKeep = document
          .getElement("settings")
          ?.getElement("days-to-keep")
          ?.innerText ??
          "";

      String secondsToWait = document
          .getElement("settings")
          ?.getElement("seconds-to-wait")
          ?.innerText ??
          "";

      String pathToWakeWord = document
          .getElement("settings")
          ?.getElement("path-to-wake-word")
          ?.innerText ??
          "";

      return new Setting(daysToKeep, secondsToWait, pathToWakeWord);
    } catch (e) {
      // this means the file doesn't exist yet, save a new file with the default values
      return Setting("7", "5", "ok_so.ppn");
    }
  }  
}


