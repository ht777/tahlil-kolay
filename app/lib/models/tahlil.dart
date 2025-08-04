import 'dart:convert';

class Tahlil {
  final int? id;
  final String date;
  final Map<String, double?> data; // {"Glukoz":110, "Kolesterol":200}
  final String report;

  Tahlil({
    this.id,
    required this.date,
    required this.data,
    required this.report,
  });

  Map<String, dynamic> toMap() => {
        'id': id,
        'date': date,
        'data': jsonEncode(data),
        'report': report,
      };

  factory Tahlil.fromMap(Map<String, dynamic> map) => Tahlil(
        id: map['id'],
        date: map['date'],
        data: Map<String, double?>.from(jsonDecode(map['data'])),
        report: map['report'],
      );
}
