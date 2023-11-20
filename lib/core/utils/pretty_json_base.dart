import 'dart:convert';
import 'dart:developer';

///
/// prettyJson
/// Return a formatted, human readable, string.
///
/// Takes a json object and optional indent size,
/// returns a formatted String
///
/// @Map<String,dynamic> json
/// @int indent
///
///
String prettyJson(dynamic json, {int indent = 2}) {
  var spaces = ' ' * indent;
  var encoder = JsonEncoder.withIndent(spaces);
  return encoder.convert(json);
}

void printPrettyJson(dynamic json, {int indent = 2}) {
  log(prettyJson(json, indent: indent));
}
