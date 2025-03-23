import 'package:flutter/material.dart';

class EmotionTrackerScreen extends StatelessWidget {
  const EmotionTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Emotion Tracker'),
        backgroundColor: Colors.orange,
      ),
      body: Center(
        child: Text(
          'Track Your Emotions',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}