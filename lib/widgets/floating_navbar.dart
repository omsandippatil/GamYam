import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FloatingNavbar extends StatelessWidget {
  const FloatingNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current route name to highlight the active tab
    final String currentRoute = ModalRoute.of(context)?.settings.name ?? '/';
    
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(35),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            // Home Button
            _buildNavItem(
              context: context,
              icon: Icons.home_rounded,
              label: 'Home',
              route: '/',
              isActive: currentRoute == '/' || currentRoute == '/home',
              color: const Color(0xFF3D405B),
            ),
            
            // Food/Calorie Tracker Button
            _buildNavItem(
              context: context,
              icon: Icons.restaurant_rounded,
              label: 'Food',
              route: '/calorie-tracker',
              isActive: currentRoute == '/calorie-tracker',
              color: const Color(0xFF2ECC71),
            ),
            
            // Emotion Tracker Button
            _buildNavItem(
              context: context,
              icon: Icons.mood_rounded,
              label: 'Mood',
              route: '/emotion-tracker',
              isActive: currentRoute == '/emotion-tracker',
              color: const Color(0xFFFFD166),
            ),
            
            // Todo List Button
            _buildNavItem(
              context: context,
              icon: Icons.check_circle_outline_rounded,
              label: 'Tasks',
              route: '/todo-list',
              isActive: currentRoute == '/todo-list',
              color: const Color(0xFF9B59B6),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String label,
    required String route,
    required bool isActive,
    required Color color,
  }) {
    return GestureDetector(
      onTap: () {
        if (!isActive) {
          // Handle navigation based on the route
          switch (route) {
            case '/':
              // We're already on home, no need to navigate
              break;
            case '/calorie-tracker':
              Navigator.pushReplacementNamed(context, '/calorie-tracker');
              // Alternative approach if named routes aren't set up:
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const CalorieTrackerScreen(),
              //   ),
              // );
              break;
            case '/emotion-tracker':
              Navigator.pushReplacementNamed(context, '/emotion-tracker');
              // Alternative approach:
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const EmotionTrackerScreen(),
              //   ),
              // );
              break;
            case '/todo-list':
              Navigator.pushReplacementNamed(context, '/todo-list');
              // Alternative approach:
              // Navigator.pushReplacement(
              //   context,
              //   MaterialPageRoute(
              //     builder: (context) => const TodoListScreen(),
              //   ),
              // );
              break;
          }
        }
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icon with conditional styling
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: isActive ? color.withOpacity(0.1) : Colors.transparent,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? color : Colors.grey.shade400,
              size: 24,
            ),
          ),
          // Label with conditional styling
          Text(
            label,
            style: GoogleFonts.outfit(
              color: isActive ? color : Colors.grey.shade400,
              fontSize: 12,
              fontWeight: isActive ? FontWeight.w500 : FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}