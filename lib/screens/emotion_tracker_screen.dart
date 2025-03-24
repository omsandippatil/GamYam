import 'dart:math';
import 'package:flutter/material.dart';
import 'package:gamyam/widgets/floating_navbar.dart';

class EmotionTrackerScreen extends StatefulWidget {
  const EmotionTrackerScreen({super.key});

  @override
  State<EmotionTrackerScreen> createState() => _EmotionTrackerScreenState();
}

class _EmotionTrackerScreenState extends State<EmotionTrackerScreen>
    with TickerProviderStateMixin {
  // Emotion options
  final List<String> emotions = [
    'Joy', 'Calm', 'Focus', 'Energy',
    'Love', 'Peace', 'Hope', 'Curious', 'Grateful'
  ];
  
  // Enhanced bubble properties
  final double minBubbleSize = 90; // Increased from 70
  final double maxBubbleSize = 150; // Increased from 120
  final double bubblePadding = 12; // Increased from 10
  
  // State variables
  final Random random = Random();
  late List<Bubble> bubbles;
  late List<AnimationController> floatControllers;
  int? selectedIndex;

  @override
  void initState() {
    super.initState();
    
    // Initialize with empty bubbles - actual positions will be set in first layout
    bubbles = List.generate(
      emotions.length, 
      (i) => Bubble(
        position: Offset.zero,
        size: minBubbleSize,
        clickCount: 0,
        velocity: Offset.zero,
      )
    );
    
    // Create animation controllers for smoother floating effect
    floatControllers = List.generate(
      emotions.length,
      (i) => AnimationController(
        vsync: this,
        duration: Duration(seconds: 4 + random.nextInt(3)), // Slightly longer for smoother animation
      )..forward()..repeat(reverse: true), // Smoother back-and-forth motion
    );
  }

  @override
  void dispose() {
    for (final controller in floatControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  // Arrange bubbles in a more aesthetic circular pattern
  void _arrangeBubblesCircular(Size size) {
    final center = Offset(size.width / 2, size.height / 2 + 20); // Slight offset from center
    final radius = min(size.width, size.height) * 0.38; // Increased radius
    
    for (int i = 0; i < bubbles.length; i++) {
      // Slightly randomize the initial positions for more organic feel
      final angle = 2 * pi * i / bubbles.length + (random.nextDouble() * 0.15);
      final randomRadius = radius * (0.95 + random.nextDouble() * 0.1);
      final x = center.dx + randomRadius * cos(angle);
      final y = center.dy + randomRadius * sin(angle);
      
      bubbles[i] = bubbles[i].copyWith(
        position: Offset(x, y),
      );
    }
  }

  // Smoother bubble collision physics
  void _updateBubblePositions() {
    for (int i = 0; i < bubbles.length; i++) {
      // Apply velocity with damping
      final newPosition = bubbles[i].position + bubbles[i].velocity;
      bubbles[i] = bubbles[i].copyWith(position: newPosition);
      
      // Apply smoother friction
      if (bubbles[i].velocity.distance > 0.1) {
        bubbles[i] = bubbles[i].copyWith(
          velocity: bubbles[i].velocity * 0.92, // More gentle deceleration
        );
      } else {
        bubbles[i] = bubbles[i].copyWith(velocity: Offset.zero);
      }
      
      // Check for collisions with other bubbles
      for (int j = 0; j < bubbles.length; j++) {
        if (i != j) {
          _handleBubbleCollision(i, j);
        }
      }
      
      // Check for wall collisions
      _handleWallCollision(i);
    }
  }

  void _handleBubbleCollision(int i, int j) {
    final bubble1 = bubbles[i];
    final bubble2 = bubbles[j];
    
    final dx = bubble1.position.dx - bubble2.position.dx;
    final dy = bubble1.position.dy - bubble2.position.dy;
    final distance = sqrt(dx * dx + dy * dy);
    final minDistance = (bubble1.size + bubble2.size) / 2;
    
    if (distance < minDistance) {
      // Calculate collision response with improved physics
      final directionX = dx / max(distance, 0.1); // Avoid division by zero
      final directionY = dy / max(distance, 0.1);
      final direction = Offset(directionX, directionY);
      final overlap = minDistance - distance;
      
      // Smoother collision response
      bubbles[i] = bubble1.copyWith(
        position: bubble1.position + direction * overlap * 0.6,
        velocity: bubble1.velocity + direction * 1.8, // Gentler response
      );
      
      bubbles[j] = bubble2.copyWith(
        position: bubble2.position - direction * overlap * 0.6,
        velocity: bubble2.velocity - direction * 1.8,
      );
    }
  }

  void _handleWallCollision(int i) {
    final bubble = bubbles[i];
    final size = MediaQuery.of(context).size;
    final radius = bubble.size / 2;
    
    // Horizontal walls with softer bouncing
    if (bubble.position.dx - radius < 0) {
      bubbles[i] = bubble.copyWith(
        position: Offset(radius + 1, bubble.position.dy), // Small offset to prevent sticking
        velocity: Offset(-bubble.velocity.dx * 0.7, bubble.velocity.dy), // Softer bounce
      );
    } else if (bubble.position.dx + radius > size.width) {
      bubbles[i] = bubble.copyWith(
        position: Offset(size.width - radius - 1, bubble.position.dy),
        velocity: Offset(-bubble.velocity.dx * 0.7, bubble.velocity.dy),
      );
    }
    
    // Vertical walls with softer bouncing
    if (bubble.position.dy - radius < 0) {
      bubbles[i] = bubble.copyWith(
        position: Offset(bubble.position.dx, radius + 1),
        velocity: Offset(bubble.velocity.dx, -bubble.velocity.dy * 0.7),
      );
    } else if (bubble.position.dy + radius > size.height - 100) {
      bubbles[i] = bubble.copyWith(
        position: Offset(bubble.position.dx, size.height - 100 - radius - 1),
        velocity: Offset(bubble.velocity.dx, -bubble.velocity.dy * 0.7),
      );
    }
  }

  void _growBubble(int index) {
    setState(() {
      // Increment click count
      final newClickCount = bubbles[index].clickCount + 1;
      
      // Smoother growth curve with more dynamic range
      final growthFactor = 1.0 + (newClickCount * 0.08);
      final newSize = min(minBubbleSize * growthFactor, maxBubbleSize);
      
      // More aesthetically pleasing random movement
      final randomAngle = random.nextDouble() * 2 * pi;
      final speed = 2.0 + random.nextDouble() * 4.0; // Slightly gentler
      final newVelocity = Offset(
        cos(randomAngle) * speed,
        sin(randomAngle) * speed,
      );
      
      // Update the bubble
      bubbles[index] = bubbles[index].copyWith(
        size: newSize,
        clickCount: newClickCount,
        velocity: newVelocity,
      );
      
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    
    // Arrange bubbles on first layout
    if (bubbles.first.position == Offset.zero) {
      _arrangeBubblesCircular(size);
    }
    
    // Update bubble positions with physics - smoother animation with less delay
    Future.delayed(const Duration(milliseconds: 12), () {
      if (mounted) {
        setState(() {
          _updateBubblePositions();
        });
      }
    });
    
    return Scaffold(
      backgroundColor: Colors.yellow[50], // Keeping the same theme
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Enhanced background pattern
            CustomPaint(
              painter: BackgroundPatternPainter(),
              size: size,
            ),
            
            // Emotion bubbles
            for (int i = 0; i < emotions.length; i++)
              _buildBubble(i),
            
            // Enhanced centered title with more refined styling
            Positioned(
              top: 40,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 28,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(230), // Slightly more opaque
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha(20), // Subtle shadow
                      blurRadius: 20,
                      spreadRadius: 1,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                margin: const EdgeInsets.symmetric(horizontal: 50),
                child: Text(
                  'How are you feeling today?',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24, // Slightly larger
                    fontWeight: FontWeight.w600,
                    color: Colors.grey[800],
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
            
            // Enhanced instruction text
            Positioned(
              bottom: 25,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(180),
                  borderRadius: BorderRadius.circular(20),
                ),
                margin: const EdgeInsets.symmetric(horizontal: 80),
                child: Text(
                  'Tap bubbles to grow them',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16, // Larger
                    fontWeight: FontWeight.w500,
                    color: Colors.grey[700],
                    letterSpacing: 0.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FloatingNavbar(),
    );
  }

  Widget _buildBubble(int index) {
    final bubble = bubbles[index];
    
    return Positioned(
      left: bubble.position.dx - bubble.size / 2,
      top: bubble.position.dy - bubble.size / 2,
      child: GestureDetector(
        onTap: () => _growBubble(index),
        child: AnimatedBuilder(
          animation: floatControllers[index],
          builder: (context, child) {
            final value = floatControllers[index].value;
            // Smoother, more organic floating motion
            return Transform.translate(
              offset: Offset(
                2 * sin(value * 1.5 * pi), // Gentle horizontal movement
                4 * sin(value * 2 * pi),   // Slightly larger vertical movement
              ),
              child: child,
            );
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 350), // Smoother transition
            curve: Curves.easeOutQuart, // More pleasing animation curve
            width: bubble.size,
            height: bubble.size,
            decoration: BoxDecoration(
              color: HSLColor.fromAHSL(
                0.98, // Slightly more opaque
                index * 36.0, // Same color distribution
                0.55, // Slightly more saturated
                selectedIndex == index ? 0.7 : 0.65,
              ).toColor(),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(45), // Stronger shadow
                  blurRadius: 18,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                ),
                BoxShadow(
                  color: HSLColor.fromAHSL(
                    0.35, // More visible glow
                    index * 36.0,
                    0.6, // More saturated glow
                    0.8,
                  ).toColor(),
                  blurRadius: 25, // Larger blur for nicer glow
                  spreadRadius: 2,
                ),
              ],
            ),
            child: Center(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: selectedIndex == index ? 20 : 17, // Larger text
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                  shadows: [
                    Shadow(
                      color: Colors.black.withAlpha(90), // Stronger text shadow
                      blurRadius: 3,
                      offset: const Offset(1, 1),
                    )
                  ],
                ),
                child: Text(
                  emotions[index],
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Enhanced background pattern painter
class BackgroundPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withAlpha(115) // Slightly more visible
      ..style = PaintingStyle.fill;
    
    final path = Path();
    final rng = Random(42); // Fixed seed for consistent pattern
    
    // More bubbles for richer background
    for (int i = 0; i < 40; i++) {
      final x = rng.nextDouble() * size.width;
      final y = rng.nextDouble() * size.height;
      // Varied sizes for more visual interest
      final radius = 8 + rng.nextDouble() * 35;
      
      path.addOval(Rect.fromCircle(center: Offset(x, y), radius: radius));
    }
    
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

// Bubble data class
class Bubble {
  final Offset position;
  final double size;
  final int clickCount;
  final Offset velocity;

  Bubble({
    required this.position,
    required this.size,
    required this.clickCount,
    required this.velocity,
  });

  Bubble copyWith({
    Offset? position,
    double? size,
    int? clickCount,
    Offset? velocity,
  }) {
    return Bubble(
      position: position ?? this.position,
      size: size ?? this.size,
      clickCount: clickCount ?? this.clickCount,
      velocity: velocity ?? this.velocity,
    );
  }
}