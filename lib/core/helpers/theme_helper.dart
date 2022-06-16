import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:json_theme/json_theme.dart';

Future<ThemeData> getLightTheme() async {
  final theme = Future.microtask(() async {
    final themeStr = await rootBundle.loadString('assets/appainter_theme.json');
    final themeJson = jsonDecode(themeStr);
    return ThemeDecoder.decodeThemeData(themeJson)!;
  });
  return theme;
}

Future<ThemeData> getDarkTheme() async {
  final theme = Future.microtask(() async {
    final themeStr =
        await rootBundle.loadString('assets/appainter_dark_theme.json');
    final themeJson = jsonDecode(themeStr);
    return ThemeDecoder.decodeThemeData(themeJson)!;
  });
  return theme;
}
