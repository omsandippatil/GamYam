class FoodEntry {
  final String name;
  final double calories;
  final DateTime dateTime;

  FoodEntry({
    required this.name,
    required this.calories,
    required this.dateTime,
  });

  Map<String, dynamic> toJson() => {
    'name': name,
    'calories': calories,
    'dateTime': dateTime.toIso8601String(),
  };

  factory FoodEntry.fromJson(Map<String, dynamic> json) => FoodEntry(
    name: json['name'],
    calories: json['calories'],
    dateTime: DateTime.parse(json['dateTime']),
  );
}