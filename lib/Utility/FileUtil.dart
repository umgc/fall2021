
import 'package:path_provider/path_provider.dart';
import 'package:file/file.dart';
import 'package:file/local.dart';

import 'dart:convert';

class FileUtil {


  /// The file system to use for all I/O operations. Generally LocalFileSystem()
  /// but MemoryFileSystem() is used when running unit tests.
  static FileSystem fileSystem = const LocalFileSystem();

  /// Returns the correct file directory for all text notes
  static Future<Directory> _getTextNotesDirectory() async {
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

   static Future<dynamic> readJson(String fileName) async {

     dynamic data = "";
     try {
        var textNotesDirectory = await _getTextNotesDirectory();
        final File file =
        fileSystem.file('${textNotesDirectory.path}/$fileName');
        String fileContent = file.readAsStringSync().trim();
        print("fileContent $fileContent");
        data = await json.decode(fileContent);
      } catch (e) {
      print("ERROR-Couldn't read file: ${e.toString()}");
    }
    return data;
  }

  static Future<void> writeJson(String fileName, String data) async {
     try {
        var textNotesDirectory = await _getTextNotesDirectory();
        final File file =
        fileSystem.file('${textNotesDirectory.path}/$fileName');
        file.writeAsString(data);
        print("data has been writted to file ${file.path}");
      } catch (e) {
      print("ERROR-Couldn't write to file: ${e.toString()}");
    }
  }

}