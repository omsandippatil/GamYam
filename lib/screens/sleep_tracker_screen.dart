import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:gamyam/widgets/floating_navbar.dart';

class SleepTrackerScreen extends StatelessWidget {
  const SleepTrackerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple.shade50,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 24),
          children: [
            // Page Title
            Text(
              'Sleep Insights',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.deepPurple.shade900,
              ),
            ),
            const SizedBox(height: 24),
            
            // Sleep Summary Card
            _buildCard(
              title: 'Last Night',
              icon: Icons.nightlight_round,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '6h 40m',
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                              color: Colors.deepPurple.shade900,
                            ),
                          ),
                          Text(
                            'Mar 23, 11:30 PM - 6:10 AM',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.deepPurple.shade400,
                            ),
                          ),
                        ],
                      ),
                      _buildPill('Good'),
                    ],
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Sleep Cycle Graph
                  Text(
                    'Sleep Cycles',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.deepPurple.shade800,
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 160,
                    child: SleepCycleGraph(),
                  ),
                  
                  const SizedBox(height: 16),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildLegendItem('Deep Sleep', Colors.deepPurple.shade900),
                      const SizedBox(width: 16),
                      _buildLegendItem('Light Sleep', Colors.deepPurple.shade300),
                      const SizedBox(width: 16),
                      _buildLegendItem('REM', Colors.deepPurple.shade200),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Sleep Debt Card
            _buildCard(
              title: 'Sleep Debt',
              icon: Icons.access_time_filled_rounded,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '3h 20m',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple.shade900,
                        ),
                      ),
                      Text(
                        'Current Sleep Debt',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.deepPurple.shade400,
                        ),
                      ),
                    ],
                  ),
                  _buildPill('Week: -5h 40m'),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Weekly Sleep Analysis Card
            _buildCard(
              title: 'Weekly Analysis',
              icon: Icons.insert_chart_outlined_rounded,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Sleep Duration',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.deepPurple.shade800,
                        ),
                      ),
                      Text(
                        'Average: 6h 50m',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.deepPurple.shade500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    height: 180,
                    child: WeeklySleepGraph(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Sleep Quality Metrics
            _buildCard(
              title: 'Sleep Quality',
              icon: Icons.health_and_safety_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: _buildQualityMetric(
                          'Sleep Efficiency',
                          '87%',
                          Icons.timer_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQualityMetric(
                          'Deep Sleep',
                          '1h 45m',
                          Icons.waves,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: _buildQualityMetric(
                          'REM Sleep',
                          '1h 20m',
                          Icons.remove_red_eye_outlined,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildQualityMetric(
                          'Awakenings',
                          '2 times',
                          Icons.notifications_active_outlined,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const FloatingNavbar(),
    );
  }
  
  Widget _buildCard({required String title, required IconData icon, required Widget child}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.deepPurple.shade200.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  icon,
                  color: Colors.deepPurple.shade600,
                  size: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple.shade800,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            child,
          ],
        ),
      ),
    );
  }
  
  Widget _buildPill(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade100,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (text == 'Good') ...[
            Icon(
              Icons.star,
              size: 16,
              color: Colors.deepPurple.shade700,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Colors.deepPurple.shade700,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.deepPurple.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildQualityMetric(String label, String value, IconData icon) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.deepPurple.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.deepPurple.shade100, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 16,
                color: Colors.deepPurple.shade500,
              ),
              const SizedBox(width: 4),
              Text(
                label,
                style: TextStyle(
                  fontSize: 13,
                  color: Colors.deepPurple.shade600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            value,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple.shade800,
            ),
          ),
        ],
      ),
    );
  }
}

class SleepCycleGraph extends StatelessWidget {
  const SleepCycleGraph({super.key});

  @override
  Widget build(BuildContext context) {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 1,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.deepPurple.shade50,
              strokeWidth: 1,
            );
          },
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: (value, meta) {
                String text = '';
                switch (value.toInt()) {
                  case 0:
                    text = 'Awake';
                    break;
                  case 1:
                    text = 'REM';
                    break;
                  case 2:
                    text = 'Light';
                    break;
                  case 3:
                    text = 'Deep';
                    break;
                }
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.deepPurple.shade300,
                      fontSize: 10,
                    ),
                  ),
                );
              },
              reservedSize: 40,
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 22,
              interval: 4,
              getTitlesWidget: (value, meta) {
                String text = '';
                switch (value.toInt()) {
                  case 0:
                    text = '11:30 PM';
                    break;
                  case 4:
                    text = '1:30 AM';
                    break;
                  case 8:
                    text = '3:30 AM';
                    break;
                  case 12:
                    text = '5:30 AM';
                    break;
                }
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    text,
                    style: TextStyle(
                      color: Colors.deepPurple.shade300,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.deepPurple.shade100, width: 1),
        ),
        minX: 0,
        maxX: 14,
        minY: 0,
        maxY: 3,
        lineBarsData: [
          LineChartBarData(
            spots: const [
              FlSpot(0, 1),
              FlSpot(1, 2),
              FlSpot(2, 2.5),
              FlSpot(3, 1.5),
              FlSpot(4, 1),
              FlSpot(5, 2),
              FlSpot(6, 2.8),
              FlSpot(7, 1.8),
              FlSpot(8, 1),
              FlSpot(9, 1.5),
              FlSpot(10, 2.2),
              FlSpot(11, 1.8),
              FlSpot(12, 1),
              FlSpot(13, 0.5),
              FlSpot(14, 0.2),
            ],
            isCurved: true,
            color: Colors.deepPurple.shade600,
            barWidth: 2,
            isStrokeCapRound: true,
            dotData: const FlDotData(show: false),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple.shade400.withOpacity(0.3),
                  Colors.deepPurple.shade100.withOpacity(0.1),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class WeeklySleepGraph extends StatelessWidget {
  const WeeklySleepGraph({super.key});

  @override
  Widget build(BuildContext context) {
    final goalHours = 8.0;
    
    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceEvenly,
        maxY: 10,
        minY: 0,
        barTouchData: BarTouchData(
          enabled: true,
          touchTooltipData: BarTouchTooltipData(
            getTooltipItem: (group, groupIndex, rod, rodIndex) {
              final hours = rod.toY.toStringAsFixed(1);
              return BarTooltipItem(
                '$hours hours',
                TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              );
            },
          ),
        ),
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 2,
              getTitlesWidget: (value, meta) {
                return Padding(
                  padding: const EdgeInsets.only(right: 4.0),
                  child: Text(
                    '${value.toInt()}h',
                    style: TextStyle(
                      color: Colors.deepPurple.shade300,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (double value, TitleMeta meta) {
                const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                final isSelected = value.toInt() == 6; // Highlight current day (Sun)
                
                return Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    days[value.toInt()],
                    style: TextStyle(
                      color: isSelected 
                          ? Colors.deepPurple.shade700
                          : Colors.deepPurple.shade300,
                      fontSize: 10,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    ),
                  ),
                );
              },
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 2,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: Colors.deepPurple.shade50,
              strokeWidth: 1,
            );
          },
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(color: Colors.deepPurple.shade100, width: 1),
        ),
        barGroups: [
          _createBarGroup(0, 6.8, goalHours),
          _createBarGroup(1, 7.2, goalHours),
          _createBarGroup(2, 6.0, goalHours),
          _createBarGroup(3, 8.5, goalHours),
          _createBarGroup(4, 5.5, goalHours),
          _createBarGroup(5, 7.8, goalHours),
          _createBarGroup(6, 6.7, goalHours, isSelected: true),
        ],
        extraLinesData: ExtraLinesData(
          horizontalLines: [
            HorizontalLine(
              y: goalHours,
              color: Colors.deepPurple.shade300,
              strokeWidth: 1,
              dashArray: [5, 5],
              label: HorizontalLineLabel(
                show: true,
                alignment: Alignment.topRight,
                padding: const EdgeInsets.only(right: 4, bottom: 4),
                style: TextStyle(
                  color: Colors.deepPurple.shade500,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
                labelResolver: (line) => 'Goal',
              ),
            ),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _createBarGroup(int x, double hours, double goalHours, {bool isSelected = false}) {
    Color barColor;
    
    if (hours >= goalHours) {
      barColor = Colors.deepPurple.shade400;
    } else if (hours >= goalHours - 1) {
      barColor = Colors.deepPurple.shade300;
    } else {
      barColor = Colors.deepPurple.shade200;
    }
    
    if (isSelected) {
      barColor = Colors.deepPurple.shade600;
    }
    
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: hours,
          color: barColor,
          width: 16,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(4),
            topRight: Radius.circular(4),
          ),
        ),
      ],
    );
  }
}