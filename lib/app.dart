import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'screens/welcome_screen.dart';

class GamYamApp extends StatelessWidget {
  const GamYamApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Set status bar color to transparent
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'GamYam',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(
          primary: const Color(0xFFD4A373), // light beige
          secondary: const Color(0xFFE76F51), // soft red
          tertiary: const Color(0xFF4A4E69),
          surface: Colors.white,
        ),
        fontFamily: 'Poppins',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontSize: 32,
            fontWeight: FontWeight.bold,
            color: Color(0xFF2F3542),
          ),
          displayMedium: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: Color(0xFF2F3542),
          ),
          bodyLarge: TextStyle(
            fontSize: 16,
            color: Color(0xFF2F3542),
          ),
          bodyMedium: TextStyle(
            fontSize: 14,
            color: Color(0xFF2F3542),
          ),
        ),
      ),
      home: const WelcomeScreen(),
    );
  }
}