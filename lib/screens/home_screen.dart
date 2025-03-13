import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        backgroundColor: const Color(0xFFE07A5F),
      ),
      body: const Center(
        child: Text(
          'Welcome to Home Screen',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF3D405B),
          ),
        ),
      ),
    );
  }
}
