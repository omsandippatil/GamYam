import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gamyam/widgets/dashboard/stat_card.dart';

class StatsGrid extends StatelessWidget {
  const StatsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 20,
      mainAxisSpacing: 20,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: const [
        StatCard(
          value: '485',
          label: 'Calories Burned',
          color: Color(0xFFFF6B6B),
        ),
        StatCard(
          value: '3.5',
          label: 'Hours Focused',
          color: Color(0xFFFFD166),
        ),
        StatCard(
          value: '1.2',
          label: 'Sleep Debt (hrs)',
          color: Color(0xFF9B59B6),
        ),
        StatCard(
          value: '1,840',
          label: 'Calories Intake',
          color: Color(0xFF2ECC71),
        ),
      ],
    );
  }
}