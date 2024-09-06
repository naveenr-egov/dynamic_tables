// lib/data_access.dart
import 'dart:io';
import 'model.dart';
import 'input_validator.dart';

class DataAccess extends InputValidator {
  final String dbPath;

  DataAccess(this.dbPath);

  Future<void> createTable(DynamicTable table) async {
    validateName(table.name) ? create(table) : throwError('Invalid table name');
  }

  Future<void> insertRow(String tableName, Map<String, String> row) async {
    final columns = row.keys.join(', ');
    final values = row.values.map((v) => "'$v'").join(', ');
    final query = validateName(tableName)
        ? 'INSERT INTO $tableName ($columns) VALUES ($values)'
        : throwError('Invalid table name');
    await _execute(query);
  }

  Future<List<Map<String, String>>> getRows(String tableName) async {
    final query = validateName(tableName)
        ? 'SELECT * FROM $tableName'
        : throwError('Invalid table name');
    return await _query(query);
  }

  Future<void> _execute(String query) async {
    final file = File(dbPath);
    final sink = file.openWrite();
    sink.write('$query;\n');
    await sink.flush();
    await sink.close();
  }

  Future<List<Map<String, String>>> _query(String query) async {
    final file = File(dbPath);
    final lines = await file.readAsLines();
    // Simulate database query results
    return lines
        .where((line) => line.contains(query.split(' ')[3]))
        .map((line) => {
              'result': line,
            })
        .toList();
  }

  create(DynamicTable table) async {
    final columnDefs = table.fields.map((col) => '$col TEXT').join(', ');
    final query = 'CREATE TABLE IF NOT EXISTS ${table.name} ($columnDefs)';
    await _execute(query);
  }
}
