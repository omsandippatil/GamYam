import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/food_water_log_screen.dart';
import 'screens/leaderboard_screen.dart';
import 'screens/emotion_tracker_screen.dart';
import 'screens/profile_screen.dart';

Map<String, WidgetBuilder> routes = {
  '/': (context) => const HomeScreen(),
  '/food-water': (context) => const FoodWaterLogScreen(),
  '/leaderboard': (context) => const LeaderboardScreen(),
  '/emotion-tracker': (context) => const EmotionTrackerScreen(),
  '/profile': (context) => const ProfileScreen(),
};
