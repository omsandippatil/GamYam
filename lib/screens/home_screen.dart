import 'package:flutter/material.dart';
import 'package:gamyam/screens/profile_screen.dart';
import 'package:gamyam/widgets/floating_navbar.dart';
import 'package:gamyam/widgets/dashboard/dashboard_header.dart';
import 'package:gamyam/widgets/dashboard/life_energy_bar.dart';
import 'package:gamyam/widgets/dashboard/stats_grid.dart';
import 'package:gamyam/widgets/dashboard/weekly_progress_chart.dart';
import 'package:gamyam/widgets/dashboard/focus_hours_chart.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F2EA),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const DashboardHeader(),
                
                const SizedBox(height: 40),
                
                const LifeEnergyBar(),
                
                const SizedBox(height: 40),
                
                const StatsGrid(),
                
                const SizedBox(height: 40),
                
                const WeeklyProgressChart(),
                
                const SizedBox(height: 40),
                
                const FocusHoursChart(),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: const FloatingNavbar(),
    );
  }
}
