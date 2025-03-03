import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'dart:math';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Custom color palette using the same colors
    final appColors = [
      const Color(0xFF33869C), // Teal blue
      const Color(0xFF885053), // Dusty rose
      const Color(0xFF797CA5), // Lavender
      const Color(0xFFD5583C), // Terracotta
      const Color(0xFF9EC686), // Sage green
      const Color(0xFFCAC548), // Mustard yellow
    ];

    // Light beige as primary background
    final primaryColor = const Color(0xFFF8F3EB);
    final accentColor = appColors[0]; // Using teal as the primary accent

    return Scaffold(
      backgroundColor: primaryColor,
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Responsive layout adjustments based on screen width
          final isWideScreen = constraints.maxWidth > 600;

          return SafeArea(
            child: Stack(
              children: [
                // Subtle decorative elements
                _BackgroundDecorations(colors: appColors),

                // Main content
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: isWideScreen ? 80.0 : 30.0,
                      vertical: 20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: isWideScreen ? 60 : 30),

                        // App title card
                        _TitleCard(
                          colors: appColors,
                          isWideScreen: isWideScreen,
                        ),

                        const SizedBox(height: 30),

                        // App description text - moved up
                        Container(
                          width:
                              isWideScreen
                                  ? constraints.maxWidth * 0.6
                                  : double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            'Transform your habits with mindful tracking and friendly competition. Block distractions, monitor your wellness, and reach your full potential.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: isWideScreen ? 20 : 18,
                              color: const Color(0xFF555555),
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.3,
                              height: 1.5,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30),

                        // Get started button - moved up before features
                        _StartButton(
                          color: accentColor,
                          accentColor: appColors[5],
                        ),

                        const SizedBox(height: 40),

                        // App features showcase
                        _FeatureShowcase(
                          colors: appColors,
                          isWideScreen: isWideScreen,
                        ),

                        SizedBox(height: isWideScreen ? 60 : 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _TitleCard extends StatelessWidget {
  final List<Color> colors;
  final bool isWideScreen;

  const _TitleCard({required this.colors, required this.isWideScreen});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isWideScreen ? 50 : 40,
        horizontal: 20,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: colors[0].withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
        border: Border.all(color: colors[4].withOpacity(0.3), width: 1.5),
      ),
      child: Column(
        children: [
          // App name in English - using solid color instead of gradient
          Text(
            'GamYam',
            style: TextStyle(
              fontSize: isWideScreen ? 58 : 48,
              fontWeight: FontWeight.w800,
              color: colors[0], // Using teal instead of gradient
              letterSpacing: -0.5,
              height: 1.1,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 15),

          // App name in Telugu - using solid color
          Text(
            'గామ్యం',
            style: TextStyle(
              fontSize: isWideScreen ? 42 : 34,
              fontWeight: FontWeight.w600,
              color: colors[4], // Using sage green instead of gradient
              height: 1.1,
              shadows: [
                Shadow(
                  color: Colors.black.withOpacity(0.15),
                  offset: const Offset(1, 2),
                  blurRadius: 3,
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          // Tagline with solid color
          Text(
            'Your Journey to Wellness',
            style: TextStyle(
              fontSize: isWideScreen ? 20 : 18,
              fontWeight: FontWeight.w500,
              color: colors[1], // Keeping dusty rose
              letterSpacing: 0.8,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class _FeatureShowcase extends StatelessWidget {
  final List<Color> colors;
  final bool isWideScreen;

  const _FeatureShowcase({required this.colors, required this.isWideScreen});

  @override
  Widget build(BuildContext context) {
    final features = [
      {
        'icon': Icons.block_rounded,
        'title': 'Block Distractions',
        'color': colors[3], // Terracotta
        'description': 'Focus on what matters',
      },
      {
        'icon': Icons.water_drop_outlined,
        'title': 'Track Hydration',
        'color': colors[0], // Teal blue
        'description': 'Stay properly hydrated',
      },
      {
        'icon': Icons.restaurant_outlined,
        'title': 'Monitor Nutrition',
        'color': colors[4], // Sage green
        'description': 'Eat healthier meals',
      },
      {
        'icon': Icons.fitness_center_outlined,
        'title': 'Exercise Tracking',
        'color': colors[2], // Lavender
        'description': 'Build consistent habits',
      },
      {
        'icon': Icons.nightlight_outlined,
        'title': 'Sleep Analysis',
        'color': colors[1], // Dusty rose
        'description': 'Improve sleep quality',
      },
      {
        'icon': Icons.leaderboard_outlined,
        'title': 'Leaderboards',
        'color': colors[5], // Mustard yellow
        'description': 'Compete with friends',
      },
    ];

    // For wide screens - grid layout with 3 features per row
    if (isWideScreen) {
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 0; i < 3; i++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _FeatureCard(
                      icon: features[i]['icon'] as IconData,
                      title: features[i]['title'] as String,
                      description: features[i]['description'] as String,
                      color: features[i]['color'] as Color,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              for (int i = 3; i < 6; i++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: _FeatureCard(
                      icon: features[i]['icon'] as IconData,
                      title: features[i]['title'] as String,
                      description: features[i]['description'] as String,
                      color: features[i]['color'] as Color,
                    ),
                  ),
                ),
            ],
          ),
        ],
      );
    } else {
      // For mobile layout - compact horizontal cards
      return Column(
        children: [
          for (final feature in features)
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: _FeatureCard(
                icon: feature['icon'] as IconData,
                title: feature['title'] as String,
                description: feature['description'] as String,
                color: feature['color'] as Color,
                isHorizontal: true,
              ),
            ),
        ],
      );
    }
  }
}

class _FeatureCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Color color;
  final bool isHorizontal;

  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.color,
    this.isHorizontal = false,
  });

  @override
  Widget build(BuildContext context) {
    final cardContent = [
      // Icon with color accent
      Container(
        width: isHorizontal ? 50 : 60,
        height: isHorizontal ? 50 : 60,
        decoration: BoxDecoration(
          color: color.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Icon(icon, color: color, size: isHorizontal ? 24 : 28),
      ),

      SizedBox(height: isHorizontal ? 0 : 16, width: isHorizontal ? 16 : 0),

      // Text content
      Flexible(
        child: Column(
          crossAxisAlignment:
              isHorizontal
                  ? CrossAxisAlignment.start
                  : CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: isHorizontal ? 16 : 18,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF333333),
                letterSpacing: 0.3,
              ),
              textAlign: isHorizontal ? TextAlign.left : TextAlign.center,
            ),
            SizedBox(height: isHorizontal ? 4 : 8),
            Text(
              description,
              style: TextStyle(
                fontSize: isHorizontal ? 14 : 15,
                color: const Color(0xFF777777),
                fontWeight: FontWeight.w400,
              ),
              textAlign: isHorizontal ? TextAlign.left : TextAlign.center,
            ),
          ],
        ),
      ),
    ];

    return Container(
      padding: EdgeInsets.all(isHorizontal ? 14.0 : 20.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(color: color.withOpacity(0.2), width: 1),
      ),
      child:
          isHorizontal
              ? Row(children: cardContent)
              : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: cardContent,
              ),
    );
  }
}

class _StartButton extends StatelessWidget {
  final Color color;
  final Color accentColor;

  const _StartButton({required this.color, required this.accentColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed:
          () => Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen()),
          ),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: color,
        elevation: 8,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        shadowColor: color.withOpacity(0.4),
        minimumSize: const Size(240, 60),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Begin Your Journey',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
            ),
          ),
          const SizedBox(width: 12),
          Icon(Icons.arrow_forward_rounded, color: accentColor, size: 24),
        ],
      ),
    );
  }
}

class _BackgroundDecorations extends StatefulWidget {
  final List<Color> colors;

  const _BackgroundDecorations({required this.colors});

  @override
  State<_BackgroundDecorations> createState() => _BackgroundDecorationsState();
}

class _BackgroundDecorationsState extends State<_BackgroundDecorations>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 18),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Top right decoration
        Positioned(
          top: -120,
          right: -100,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  30 * sin(_controller.value * 3.14),
                  20 * cos(_controller.value * 3.14),
                ),
                child: child,
              );
            },
            child: Container(
              width: 280,
              height: 280,
              decoration: BoxDecoration(
                color: widget.colors[0].withOpacity(0.08),
                borderRadius: BorderRadius.circular(140),
              ),
            ),
          ),
        ),

        // Middle left decoration
        Positioned(
          top: MediaQuery.of(context).size.height * 0.4,
          left: -80,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  15 * cos(_controller.value * 3.14 * 0.5),
                  25 * sin(_controller.value * 3.14 * 0.5),
                ),
                child: child,
              );
            },
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                color: widget.colors[2].withOpacity(0.08),
                borderRadius: BorderRadius.circular(80),
              ),
            ),
          ),
        ),

        // Bottom right decoration
        Positioned(
          bottom: -100,
          right: -70,
          child: AnimatedBuilder(
            animation: _controller,
            builder: (context, child) {
              return Transform.translate(
                offset: Offset(
                  20 * sin(_controller.value * 3.14 * 0.7),
                  15 * cos(_controller.value * 3.14 * 0.7),
                ),
                child: child,
              );
            },
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: widget.colors[5].withOpacity(0.08),
                borderRadius: BorderRadius.circular(110),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
