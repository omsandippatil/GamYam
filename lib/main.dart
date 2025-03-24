import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; 
import 'screens/home_screen.dart';
import 'screens/calorie_tracker_screen.dart';
import 'screens/emotion_tracker_screen.dart';
import 'screens/sleep_tracker_screen.dart';
import 'screens/dashboard_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gamyam',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFFD0BFE6), // Light Purple
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      // Define all routes for the app
      initialRoute: '/',
      routes: {
        '/': (context) => const WelcomePage(),
        '/home': (context) => const HomeScreen(),
        '/calorie-tracker': (context) => const CalorieTrackerScreen(),
        '/emotion-tracker': (context) => const EmotionTrackerScreen(),
        '/sleep-tracker': (context) => const SleepTrackerScreen(),
        '/dashboard': (context) => const DashboardScreen(),
      },
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
 
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFDECFF4), Color(0xFFD0BFE6)], // Gradient background
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Top spacing
              SizedBox(height: screenHeight * 0.06),
              
              // Artwork image - removed the box but kept the image
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'images/welcome-screen.png',
                    width: screenWidth * 0.75,
                    height: screenHeight * 0.28,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              // Spacing between image and title
              SizedBox(height: screenHeight * 0.06),
              
              // Logo and app name with enhanced styling
              Center(
                child: Column(
                  children: [
                    Text(
                      'GAMYAM',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 48,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 3.5,
                        color: const Color(0xFF2E2E2E), // Dark Brown/Black
                        shadows: [
                          Shadow(
                            blurRadius: 3.0,
                            color: Colors.black.withOpacity(0.1),
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12), // Increased spacing
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
                      decoration: BoxDecoration(
                        color: const Color(0xFF9F86C0).withOpacity(0.12),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Text(
                        'கம்யம்', // Gamyam in Tamil
                        style: TextStyle(
                          fontFamily: 'Bamini', // Tamil font
                          fontSize: 36,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF9F86C0), // Purple
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Spacing between names and tagline
              SizedBox(height: screenHeight * 0.03),
              
              // Tagline with enhanced styling
              Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 40),
                  child: Text(
                    'Your journey to mindfulness',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w300,
                      color: const Color(0xFF2E2E2E), // Dark Brown/Black
                      letterSpacing: 0.8,
                      height: 1.4,
                    ),
                  ),
                ),
              ),
              
              // Flexible space - adjusts based on screen size
              Expanded(
                flex: 2,
                child: SizedBox(height: screenHeight * 0.06),
              ),
              
              // Feature icons with improved styling
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 36),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    // Food icon (darker green)
                    buildFeatureItem(
                      icon: Icons.restaurant,
                      label: 'Food',
                      color: const Color(0xFF8DAB7F), // Darker Green
                      iconColor: Colors.white,
                    ),
                    
                    // Health icon (coral)
                    buildFeatureItem(
                      icon: Icons.favorite,
                      label: 'Health',
                      color: const Color(0xFFFF7854), // Soft Coral
                      iconColor: Colors.white,
                    ),
                    
                    // Meditate icon (muted orange)
                    buildFeatureItem(
                      icon: Icons.self_improvement,
                      label: 'Meditate',
                      color: const Color(0xFFF4A261), // Muted Orange
                      iconColor: Colors.white,
                    ),
                    
                    // Sleep icon (purple)
                    buildFeatureItem(
                      icon: Icons.nightlight_round,
                      label: 'Sleep',
                      color: const Color(0xFF9F86C0), // Purple
                      iconColor: Colors.white,
                    ),
                  ],
                ),
              ),
              
              // Proper bottom spacing using Expanded instead of fixed SizedBox
              Expanded(
                flex: 1,
                child: const SizedBox(),
              ),
              
              // Get Started Button with improved styling
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
                child: ElevatedButton(
                  onPressed: () {
                    // Using named route navigation instead of MaterialPageRoute
                    Navigator.pushReplacementNamed(context, '/home');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF9F86C0), // Purple
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 2,
                    shadowColor: const Color(0xFF9F86C0).withOpacity(0.5),
                  ),
                  child: Text(
                    'GET STARTED',
                    style: GoogleFonts.montserrat(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 1.8,
                    ),
                  ),
                ),
              ),
              
              // Bottom safe area padding
              SizedBox(height: screenHeight * 0.02),
            ],
          ),
        ),
      ),
    );
  }
  
  // Helper method to create feature items
  Widget buildFeatureItem({
    required IconData icon,
    required String label,
    required Color color,
    required Color iconColor,
  }) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(14), // Slightly larger padding
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 28,
          ),
        ),
        const SizedBox(height: 12), // Increased spacing
        Text(
          label,
          style: GoogleFonts.poppins(
            color: const Color(0xFF2E2E2E),
            fontWeight: FontWeight.w500,
            fontSize: 13,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }
}