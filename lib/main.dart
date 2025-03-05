import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Import screens
import 'screens/dashboard_screen.dart';
import 'screens/calorie_tracker_screen.dart';
import 'screens/emotion_tracker_screen.dart';

void main() {
  runApp(GamYamApp());
}

class GamYamApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'GamYam',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Color(0xFFF5E6D3), // Light beige background
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      home: HomePage(),
      routes: {
        '/dashboard': (context) => DashboardScreen(),
        '/calorie-tracker': (context) => CalorieTrackerScreen(),
        '/emotion-tracker': (context) => EmotionTrackerScreen(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'గమ్యం | GamYam',
              style: GoogleFonts.poppins(
                fontSize: 64,
                fontWeight: FontWeight.w900,
                color: Colors.pink[800],
                letterSpacing: 1.5,
              ),
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildCircularButton(
                  icon: Icons.bar_chart_rounded,
                  color: Colors.purple,
                  onPressed: () {
                    Navigator.pushNamed(context, '/dashboard');
                  },
                ),
                SizedBox(width: 30),
                _buildCircularButton(
                  icon: Icons.restaurant_menu,
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushNamed(context, '/calorie-tracker');
                  },
                ),
                SizedBox(width: 30),
                _buildCircularButton(
                  icon: Icons.psychology_alt_outlined,
                  color: Colors.orange,
                  onPressed: () {
                    Navigator.pushNamed(context, '/emotion-tracker');
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCircularButton({
    required IconData icon,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return StatefulBuilder(
      builder: (context, setState) {
        bool isHovered = false;

        return MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 300),
            width: isHovered ? 140 : 120,
            height: isHovered ? 140 : 120,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color.withOpacity(isHovered ? 0.3 : 0.2),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(isHovered ? 0.5 : 0.3),
                  spreadRadius: isHovered ? 5 : 3,
                  blurRadius: isHovered ? 15 : 10,
                  offset: Offset(0, isHovered ? 8 : 5),
                ),
              ],
              border: isHovered 
                ? Border.all(color: color.withOpacity(0.5), width: 2)
                : null,
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(70),
                onTap: onPressed,
                child: Center(
                  child: Icon(
                    icon,
                    size: isHovered ? 70 : 60,
                    color: color,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}