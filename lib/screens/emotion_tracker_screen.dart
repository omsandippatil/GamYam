import 'package:flutter/material.dart';

class EmotionTrackerScreen extends StatelessWidget {
  const EmotionTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        "Emotion Tracker",
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
