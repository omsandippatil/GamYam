import 'package:flutter/material.dart';

class FoodWaterLogWidget extends StatelessWidget {
  const FoodWaterLogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Text("Today's Food & Water Intake", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Text("Breakfast: ✅"),
            Text("Lunch: ✅"),
            Text("Dinner: ❌"),
            Text("Water: 2L"),
          ],
        ),
      ),
    );
  }
}
