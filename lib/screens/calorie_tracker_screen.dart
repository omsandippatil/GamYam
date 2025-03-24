import 'package:flutter/material.dart';
import 'package:gamyam/widgets/floating_navbar.dart';
import 'package:gamyam/widgets/food/calorie_input_widget.dart';
import 'package:gamyam/widgets/food/calorie_statistics_widget.dart';
import 'package:google_fonts/google_fonts.dart';

class CalorieTrackerScreen extends StatelessWidget {
  const CalorieTrackerScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    // Define the green gradient colors
    const Color lightMint = Color(0xFFF5F9F5);
    const Color greenAccent = Color(0xFF4CAF50);
    
    return Scaffold(
      backgroundColor: lightMint,
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFEDF4F0), // Almost white with green tint
              Color(0xFFE8F5EC), // Subtle mint
              Color(0xFFDCEEE0), // Light sage
            ],
          ),
        ),
        child: SafeArea(
          child: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  floating: true,
                  snap: true,
                  expandedHeight: 60,
                  flexibleSpace: FlexibleSpaceBar(
                    background: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Calorie Tracker',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700, // Bolder text weight
                            color: const Color(0xFF2E7D32), // Dark green for text
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: const [
                  CalorieInputWidget(),
                  SizedBox(height: 24),
                  CalorieStatisticsWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: greenAccent, // Match navbar background to accent color
          primaryColor: Colors.white, // Change primary color for contrast
        ),
        child: const FloatingNavbar(),
      ),
    );
  }
}