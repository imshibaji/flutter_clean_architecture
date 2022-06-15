import 'dart:developer';
import 'dart:io';

import 'package:flutter_archive/flutter_archive.dart';

void backup(String backupDirPath, String zipFilePath) async {
  final dataDir = Directory(backupDirPath);
  try {
    final zipFile = File(zipFilePath);
    await ZipFile.createFromDirectory(
        sourceDir: dataDir, zipFile: zipFile, recurseSubDirs: true);
  } catch (e) {
    log(e.toString());
  }
}

void restore(String zipFilePath, String destinationDirPath) async {
  final zipFile = File(zipFilePath);
  final destinationDir = Directory(destinationDirPath);
  try {
    await ZipFile.extractToDirectory(
        zipFile: zipFile, destinationDir: destinationDir);
  } catch (e) {
    log(e.toString());
  }
}
