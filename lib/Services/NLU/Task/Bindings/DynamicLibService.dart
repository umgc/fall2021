import 'dart:ffi';
import 'dart:io';

const Set<String> _supported = {'linux', 'mac', 'win'};

String get binaryName {
  String os, ext;
  if (Platform.isLinux) {
    os = 'linux';
    ext = 'so';
  } else if (Platform.isMacOS) {
    os = 'mac';
    ext = 'so';
  } else if (Platform.isWindows) {
    os = 'win';
    ext = 'dll';
  } else {
    throw Exception('Unsupported platform!');
  }

  if (!_supported.contains(os)) {
    throw UnsupportedError('Unsupported platform: $os!');
  }

  return 'libtensorflowlite_c-$os.$ext';
}

DynamicLibrary tflitelib = () {
  if (Platform.isAndroid) {
    DynamicLibrary dl = DynamicLibrary.open('libtask_text_jni.so');
    return dl;
  } else if (Platform.isIOS) {
    return DynamicLibrary.process();
  } else {
    final binaryPath = Platform.script.resolveUri(Uri.directory('.')).path +
          'blobs/$binaryName';
    final binaryFilePath = Uri(path: binaryPath).toFilePath();
    return DynamicLibrary.open(binaryFilePath);
  }
}();