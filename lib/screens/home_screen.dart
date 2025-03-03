import 'package:flutter/material.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/app_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Color palette
  static const Color tealBlue = Color(0xFF33869C);
  static const Color dustyRose = Color(0xFF885053);
  static const Color lavender = Color(0xFF797CA5);
  static const Color terracotta = Color(0xFFD5583C);
  static const Color sageGreen = Color(0xFF9EC686);
  static const Color mustardYellow = Color(0xFFCAC548);
  static const Color backgroundColor = Color(0xFFF8F5F2); // Slightly warmer background

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: const CustomAppBar(title: 'GamYam'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting section with avatar
              _buildGreetingSection(context),
              const SizedBox(height: 28),
              
              // Daily wellness score with improved gradient
              _buildWellnessScoreCard(context),
              const SizedBox(height: 28),
              
              // Quick action buttons with new colors
              _buildQuickActionSection(context),
              const SizedBox(height: 32),
              
              // Today's habits with enhanced visuals
              _buildTodayHabitsSection(context),
              const SizedBox(height: 28),
              
              // Mental wellness tips with new styling
              _buildMentalTipsSection(context),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildGreetingSection(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Good morning,',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.black54,
                      fontSize: 16,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                'Ravi',
                style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: tealBlue,
                    ),
              ),
            ],
          ),
        ),
        // Notification icon with enhanced styling
        Container(
          width: 54,
          height: 54,
          decoration: BoxDecoration(
            color: tealBlue.withOpacity(0.15),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: tealBlue.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_outlined,
            color: tealBlue,
            size: 28,
          ),
        ),
      ],
    );
  }

  Widget _buildWellnessScoreCard(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [tealBlue, lavender],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: tealBlue.withOpacity(0.25),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Today\'s Wellness Score',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 22),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '78',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.arrow_upward,
                            color: Colors.white,
                            size: 14,
                          ),
                          SizedBox(width: 4),
                          Text(
                            '4%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                const Text(
                  'Good progress today!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.3),
              borderRadius: BorderRadius.circular(44),
              border: Border.all(
                color: Colors.white.withOpacity(0.4),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.favorite,
              color: Colors.white,
              size: 42,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Quick Actions',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.more_horiz, color: Colors.black54),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            _buildQuickActionButton(
              context,
              icon: Icons.water_drop,
              color: tealBlue,
              label: 'Water',
            ),
            const SizedBox(width: 14),
            _buildQuickActionButton(
              context,
              icon: Icons.restaurant_menu,
              color: terracotta,
              label: 'Food',
            ),
            const SizedBox(width: 14),
            _buildQuickActionButton(
              context,
              icon: Icons.mood,
              color: lavender,
              label: 'Mood',
            ),
            const SizedBox(width: 14),
            _buildQuickActionButton(
              context,
              icon: Icons.directions_run,
              color: sageGreen,
              label: 'Exercise',
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionButton(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String label,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 58,
            height: 58,
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: color.withOpacity(0.1),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: color,
              size: 28,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: color.withOpacity(0.85),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodayHabitsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Today\'s Habits',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: Colors.black87,
                  ),
            ),
            TextButton(
              onPressed: () {},
              style: TextButton.styleFrom(
                foregroundColor: tealBlue,
              ),
              child: const Text(
                'See All',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        _buildHabitItem(
          context,
          icon: Icons.water_drop,
          color: tealBlue,
          title: 'Drink 2L of water',
          progress: 0.7,
        ),
        const SizedBox(height: 14),
        _buildHabitItem(
          context,
          icon: Icons.directions_run,
          color: sageGreen,
          title: '30 min exercise',
          progress: 0.5,
        ),
        const SizedBox(height: 14),
        _buildHabitItem(
          context,
          icon: Icons.book,
          color: terracotta,
          title: 'Read for 20 minutes',
          progress: 0.0,
        ),
      ],
    );
  }

  Widget _buildHabitItem(
    BuildContext context, {
    required IconData icon,
    required Color color,
    required String title,
    required double progress,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              icon,
              color: color,
              size: 24,
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                ),
                const SizedBox(height: 10),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.black.withOpacity(0.06),
                    color: color,
                    minHeight: 9,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
              color: progress > 0 ? color.withOpacity(0.15) : Colors.grey.withOpacity(0.12),
              borderRadius: BorderRadius.circular(14),
              border: progress > 0
                  ? Border.all(color: color.withOpacity(0.3), width: 1.5)
                  : null,
            ),
            child: Icon(
              progress > 0 ? Icons.check : Icons.add,
              color: progress > 0 ? color : Colors.grey,
              size: 22,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMentalTipsSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mental Wellness',
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: Colors.black87,
              ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(22),
            border: Border.all(
              color: dustyRose.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: dustyRose.withOpacity(0.08),
                blurRadius: 15,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: dustyRose.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.tips_and_updates,
                      color: dustyRose,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    'Daily Tip',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: dustyRose,
                          fontWeight: FontWeight.w600,
                          fontSize: 18,
                        ),
                  ),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                '"Take a few moments today to practice deep breathing. Just 5 minutes of mindful breathing can significantly reduce stress and improve mental clarity."',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black87,
                      height: 1.6,
                      fontSize: 15,
                    ),
              ),
              const SizedBox(height: 22),
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: dustyRose,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  minimumSize: const Size(double.infinity, 52),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.self_improvement,
                      size: 20,
                    ),
                    SizedBox(width: 10),
                    Text(
                      'Try 2-Minute Meditation',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        letterSpacing: 0.3,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}