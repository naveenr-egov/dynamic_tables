// lib/json_parser.dart
import 'dart:convert';
import 'dart:io';
import 'model.dart';

Future<DynamicTable> parseJson(String path) async {
  final file = File(path);
  final content = await file.readAsString();
  final json = jsonDecode(content);
  return DynamicTable.fromJson(json);
}
