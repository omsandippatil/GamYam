import 'package:flutter/material.dart';
import 'package:gamyam/widgets/floating_navbar.dart';

class CalorieTrackerScreen extends StatelessWidget {
  const CalorieTrackerScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calorie Tracker'),
        backgroundColor: Colors.purple,
      ),
      body: const Center(
        child: Text(
          'Track Your Calories',
          style: TextStyle(fontSize: 24),
        ),
      ),
      bottomNavigationBar: const FloatingNavbar(),
    );
  }
}