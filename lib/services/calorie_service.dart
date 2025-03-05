import '../models/food_entry.dart';

class CalorieService {
  List<FoodEntry> _foodEntries = [];

  void addFoodEntry(FoodEntry entry) {
    _foodEntries.add(entry);
  }

  List<FoodEntry> getFoodEntries() {
    return _foodEntries;
  }

  double getTotalCalories() {
    return _foodEntries.fold(0, (total, entry) => total + entry.calories);
  }
}