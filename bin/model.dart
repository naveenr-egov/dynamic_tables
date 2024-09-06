// lib/model.dart
class DynamicTable {
  final String name;
  final List<String> fields;

  DynamicTable(this.name, this.fields);

  Map<String, dynamic> toJson() => {
        'name': name,
        'fields': fields,
      };

  factory DynamicTable.fromJson(Map<String, dynamic> json) => DynamicTable(
        json['name'],
        List<String>.from(json['fields']),
      );
}
