// lib/main.dart
import 'dart:io';

import 'data_access.dart';
import 'json_parser.dart';
import 'input_validator.dart';

void main() async {
  var dbPath = '.txt'; // Simulate database file path
  final jsonPath = 'table_definitions.json';

  print('Enter database name: ');
  final dbName = stdin.readLineSync();

  dbPath = InputValidator().validateName(dbName!)
      ? '$dbName.txt'
      : InputValidator()
          .throwError('Database name must be at least 3 characters long');

  //ask for user input
  print('Enter your name: ');
  final name = stdin.readLineSync();
  print('Enter your age: ');
  final age = stdin.readLineSync();

  // Parse JSON to create a DynamicTable
  final table = await parseJson(jsonPath);

  final dataAccess = DataAccess(dbPath);

  // Create the table
  await dataAccess.createTable(table);

  // Insert a row into the table
  await dataAccess.insertRow(table.name, {'name': name!, 'age': age!});

  // Query the table
  final rows = await dataAccess.getRows(table.name);

  print('Rows in ${table.name}:');
  rows.forEach((row) => print(row));
}
