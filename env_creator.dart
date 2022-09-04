import 'dart:io';

void main() {
  envCreator('.env.sample', '.env');
}

Future<File?> envCreator(String fileName, String newFileName) async {
  if (!File(newFileName).existsSync()) {
    var file = File(fileName);
    var path = file.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.copySync(newPath);
  }
  return null;
}
