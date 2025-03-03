class LogModel {
  final String id;
  final String type;
  final String value;
  final DateTime timestamp;

  LogModel({required this.id, required this.type, required this.value, required this.timestamp});

  factory LogModel.fromJson(Map<String, dynamic> json) {
    return LogModel(
      id: json['id'],
      type: json['type'],
      value: json['value'],
      timestamp: DateTime.parse(json['timestamp']),
    );
  }
}
