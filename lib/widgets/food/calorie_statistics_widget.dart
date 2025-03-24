import 'package:flutter/material.dart';

class CalorieStatisticsWidget extends StatelessWidget {
  const CalorieStatisticsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data for statistics
    final dailyGoal = 2000;
    final consumedToday = 1450;
    final remainingCalories = dailyGoal - consumedToday;
    final progressPercentage = (consumedToday / dailyGoal) * 100;
    
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Statistics',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B5E20),
            ),
          ),
          const SizedBox(height: 16),
          
          // Progress bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Daily Progress',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    '${progressPercentage.toInt()}%',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2E7D32),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: consumedToday / dailyGoal,
                  backgroundColor: Colors.grey.withOpacity(0.2),
                  valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF4CAF50)),
                  minHeight: 12,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Statistics grid
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.flag,
                  label: 'Goal',
                  value: '$dailyGoal',
                  unit: 'kcal',
                  color: const Color(0xFF2E7D32),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.restaurant,
                  label: 'Consumed',
                  value: '$consumedToday',
                  unit: 'kcal',
                  color: const Color(0xFF4CAF50),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: Icons.battery_charging_full,
                  label: 'Remaining',
                  value: '$remainingCalories',
                  unit: 'kcal',
                  color: const Color(0xFF8BC34A),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildStatItem(
                  icon: Icons.local_fire_department,
                  label: 'Burned',
                  value: '320',
                  unit: 'kcal',
                  color: const Color(0xFFFF9800),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 20),
          
          // Recent entries section 
          const Text(
            'Recent Entries',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1B5E20),
            ),
          ),
          const SizedBox(height: 8),
          _buildRecentEntryItem('Breakfast - Oatmeal', 350),
          _buildRecentEntryItem('Lunch - Grilled Chicken Salad', 480),
          _buildRecentEntryItem('Snack - Apple', 95),
          _buildRecentEntryItem('Coffee with Milk', 35),
        ],
      ),
    );
  }
  
  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required String unit,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[700],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: value,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
                TextSpan(
                  text: ' $unit',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildRecentEntryItem(String foodName, int calories) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            foodName,
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[800],
            ),
          ),
          Text(
            '$calories kcal',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Color(0xFF2E7D32),
            ),
          ),
        ],
      ),
    );
  }
}