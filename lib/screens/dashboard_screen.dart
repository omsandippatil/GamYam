import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:percent_indicator/percent_indicator.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF5E6D3),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(
          color: Colors.pink[800],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPageHeader(),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          _buildLifelineSection(),
                          SizedBox(height: 20),
                          _buildFocusTimeChart(),
                        ],
                      ),
                    ),
                    SizedBox(width: 20),
                    Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          _buildSocialMediaUsageCard(),
                          SizedBox(height: 20),
                          _buildNutritionTrackers(),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                _buildSleepSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildPageHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Dashboard',
          style: GoogleFonts.poppins(
            fontSize: 36,
            fontWeight: FontWeight.w800,
            color: Colors.pink[800],
          ),
        ),
        CircleAvatar(
          backgroundColor: Colors.teal.shade100,
          radius: 30,
          child: Icon(Icons.person, color: Colors.teal, size: 35),
        )
      ],
    );
  }

  Widget _buildLifelineSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.pink.shade100.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Lifeline',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.purple,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildLifelineIndicator(
                icon: Icons.favorite,
                color: Colors.red,
                value: 0.8,
                label: 'Health',
              ),
              _buildLifelineIndicator(
                icon: Icons.psychology,
                color: Colors.teal,
                value: 0.7,
                label: 'Mental',
              ),
              _buildLifelineIndicator(
                icon: Icons.energy_savings_leaf,
                color: Colors.orange,
                value: 0.6,
                label: 'Energy',
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildLifelineIndicator({
    required IconData icon,
    required Color color,
    required double value,
    required String label,
  }) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 10.0,
          percent: value,
          center: Icon(icon, color: color, size: 40),
          progressColor: color,
          backgroundColor: color.withOpacity(0.2),
        ),
        SizedBox(height: 10),
        Text(
          label,
          style: GoogleFonts.nunito(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }

Widget _buildFocusTimeChart() {
  final List<_FocusData> focusData = [
    _FocusData('Mon', 2),
    _FocusData('Tue', 3),
    _FocusData('Wed', 4),
    _FocusData('Thu', 2.5),
    _FocusData('Fri', 3.5),
    _FocusData('Sat', 1.5),
    _FocusData('Sun', 2),
  ];

  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(15),
      boxShadow: [
        BoxShadow(
          color: Colors.purple.shade100.withOpacity(0.3),
          blurRadius: 10,
          spreadRadius: 2,
        )
      ],
    ),
    padding: EdgeInsets.all(20),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Focus Time',
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: Colors.purple,
          ),
        ),
        SizedBox(height: 15),
        SizedBox(
          height: 250,
          child: SfCartesianChart(
            primaryXAxis: CategoryAxis(),
            series: <CartesianSeries<_FocusData, String>>[
              ColumnSeries<_FocusData, String>(
                dataSource: focusData,
                xValueMapper: (_FocusData data, _) => data.day,
                yValueMapper: (_FocusData data, _) => data.hours,
                color: Colors.teal.shade300,
                borderRadius: BorderRadius.circular(10),
              )
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildSocialMediaUsageCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.purple.shade100.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Social Media Usage',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.purple,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSocialMediaIcon(
                icon: Icons.facebook,
                color: Colors.blue,
                hours: 1.2,
              ),
              _buildSocialMediaIcon(
                icon: Icons.camera_alt,
                color: Colors.pink,
                hours: 2.5,
              ),
              _buildSocialMediaIcon(
                icon: Icons.tiktok,
                color: Colors.black,
                hours: 0.8,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSocialMediaIcon({
    required IconData icon,
    required Color color,
    required double hours,
  }) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(0.2),
          ),
          padding: EdgeInsets.all(12),
          child: Icon(icon, color: color, size: 40),
        ),
        SizedBox(height: 10),
        Text(
          '${hours}h',
          style: GoogleFonts.nunito(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }

  Widget _buildNutritionTrackers() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.shade100.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nutrition',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.purple,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNutritionIndicator(
                icon: Icons.water_drop,
                color: Colors.blue,
                current: 1.5,
                total: 2,
                label: 'Water',
              ),
              _buildNutritionIndicator(
                icon: Icons.fastfood,
                color: Colors.orange,
                current: 1200,
                total: 1500,
                label: 'Calories',
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildNutritionIndicator({
    required IconData icon,
    required Color color,
    required double current,
    required double total,
    required String label,
  }) {
    return Column(
      children: [
        CircularPercentIndicator(
          radius: 50.0,
          lineWidth: 10.0,
          percent: current / total,
          center: Icon(icon, color: color, size: 40),
          progressColor: color,
          backgroundColor: color.withOpacity(0.2),
        ),
        SizedBox(height: 10),
        Text(
          '$current/$total ${label == "Water" ? "L" : "cal"}',
          style: GoogleFonts.nunito(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        )
      ],
    );
  }

  Widget _buildSleepSection() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.shade100.withOpacity(0.3),
            blurRadius: 10,
            spreadRadius: 2,
          )
        ],
      ),
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Sleep Insights',
            style: GoogleFonts.poppins(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Colors.purple,
            ),
          ),
          SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSleepCard(
                icon: Icons.nightlight,
                title: 'Last Night',
                hours: 6.5,
                color: Colors.indigo,
              ),
              _buildSleepCard(
                icon: Icons.cloud_outlined,
                title: 'Sleep Debt',
                hours: 2.3,
                color: Colors.deepPurple,
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildSleepCard({
    required IconData icon,
    required String title,
    required double hours,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 40),
          SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.nunito(
              color: color,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 5),
          Text(
            '$hours hrs',
            style: GoogleFonts.poppins(
              color: color,
              fontSize: 18,
              fontWeight: FontWeight.w800,
            ),
          )
        ],
      ),
    );
  }
}

class _FocusData {
  final String day;
  final double hours;

  _FocusData(this.day, this.hours);
}