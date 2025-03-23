import 'package:flutter/material.dart';

class CalorieTrackerScreen extends StatelessWidget {
  const CalorieTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calorie Tracker'),
        backgroundColor: Colors.purple,
      ),
      body: Center(
        child: Text(
          'Track Your Calories',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}