import 'package:flutter/material.dart';

class FloatingNavbar extends StatelessWidget {
  const FloatingNavbar({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the current route name to determine active tab
    final String currentRoute = ModalRoute.of(context)?.settings.name ?? '/';
    
    // Determine the navbar color based on active page
    Color navbarColor;
    if (currentRoute == '/calorie-tracker') {
      navbarColor = const Color(0xFF2A9D5F); // Dark green for food
    } else if (currentRoute == '/emotion-tracker') {
      navbarColor = const Color(0xFFD4AB3A); // Dark yellow for mood
    } else if (currentRoute == '/sleep-tracker') {
      navbarColor = const Color(0xFF7D3C98); // Dark purple for sleep
    } else {
      navbarColor = const Color(0xFFD2B48C); // Dark beige for home
    }
    
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: navbarColor,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withAlpha(26),
              blurRadius: 20,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              context: context,
              icon: Icons.home_rounded,
              route: '/home',
              isActive: currentRoute == '/' || currentRoute == '/home',
            ),
            _buildNavItem(
              context: context,
              icon: Icons.restaurant_rounded,
              route: '/calorie-tracker',
              isActive: currentRoute == '/calorie-tracker',
            ),
            _buildNavItem(
              context: context,
              icon: Icons.mood_rounded,
              route: '/emotion-tracker',
              isActive: currentRoute == '/emotion-tracker',
            ),
            _buildNavItem(
              context: context,
              icon: Icons.nightlight_round,
              route: '/sleep-tracker',
              isActive: currentRoute == '/sleep-tracker',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String route,
    required bool isActive,
  }) {
    // Using InkWell instead of GestureDetector for better tap feedback
    return InkWell(
      onTap: () {
        if (!isActive) {
          print('Navigating to $route'); // Debug print to verify tap is detected
          Navigator.of(context).pushReplacementNamed(route);
        }
      },
      // Using Material to make InkWell work properly
      child: Material(
        color: Colors.transparent,
        child: Container(
          // Increased tap target size for better touch detection
          width: 60,
          height: 60,
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isActive ? Colors.white.withAlpha(51) : Colors.transparent,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }
}