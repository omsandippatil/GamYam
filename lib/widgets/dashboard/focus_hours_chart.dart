import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class FocusHoursChart extends StatelessWidget {
  const FocusHoursChart({super.key});

  final Color tiktokColor = const Color(0xFFE74C3C);
  final Color twitterColor = const Color(0xFF2ECC71);
  final Color instagramColor = const Color(0xFF6D3B9C);

  @override
  Widget build(BuildContext context) {
    // Sample data for hours saved
    final List<double> tiktokData = [1.2, 1.8, 2.3, 1.9, 2.5, 3.0, 2.7];
    final List<double> twitterData = [0.8, 1.2, 1.0, 1.5, 1.3, 1.8, 1.6];
    final List<double> instagramData = [1.5, 2.0, 1.7, 2.2, 2.8, 2.4, 3.2];
    
    final List<String> days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    
    // Calculate total hours saved
    final double totalTiktok = tiktokData.reduce((a, b) => a + b);
    final double totalTwitter = twitterData.reduce((a, b) => a + b);
    final double totalInstagram = instagramData.reduce((a, b) => a + b);
    final double totalHours = totalTiktok + totalTwitter + totalInstagram;

    return Container(
      width: double.infinity,
      height: 420,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Time Saved This Week',
              style: GoogleFonts.poppins(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF2D3142),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${totalHours.toStringAsFixed(1)} hours of focus time',
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF9093A3),
              ),
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(
                    show: true,
                    drawHorizontalLine: true,
                    drawVerticalLine: false,
                    horizontalInterval: 1,
                    getDrawingHorizontalLine: (value) {
                      return FlLine(
                        color: const Color(0xFFEEEEEE),
                        strokeWidth: 1,
                      );
                    },
                  ),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 30,
                        getTitlesWidget: (value, meta) {
                          if (value.toInt() >= 0 && value.toInt() < days.length) {
                            return SideTitleWidget(
                              side: meta.axisSide,
                              child: Text(
                                days[value.toInt()],
                                style: GoogleFonts.poppins(
                                  color: const Color(0xFF9093A3),
                                  fontSize: 12,
                                ),
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                        getTitlesWidget: (value, meta) {
                          return SideTitleWidget(
                            side: meta.axisSide,
                            child: Text(
                              '${value.toInt()}h',
                              style: GoogleFonts.poppins(
                                color: const Color(0xFF9093A3),
                                fontSize: 12,
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
                  borderData: FlBorderData(show: false),
                  minX: 0,
                  maxX: days.length - 1.0,
                  minY: 0,
                  maxY: 5,
                  lineBarsData: [
                    // TikTok Line
                    LineChartBarData(
                      spots: List.generate(
                        tiktokData.length,
                        (index) => FlSpot(index.toDouble(), tiktokData[index]),
                      ),
                      isCurved: true,
                      color: tiktokColor,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: tiktokColor.withAlpha(0x1A),
                      ),
                    ),
                    // Twitter Line
                    LineChartBarData(
                      spots: List.generate(
                        twitterData.length,
                        (index) => FlSpot(index.toDouble(), twitterData[index]),
                      ),
                      isCurved: true,
                      color: twitterColor,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: twitterColor.withAlpha(0x1A),
                      ),
                    ),
                    // Instagram Line
                    LineChartBarData(
                      spots: List.generate(
                        instagramData.length,
                        (index) => FlSpot(index.toDouble(), instagramData[index]),
                      ),
                      isCurved: true,
                      color: instagramColor,
                      barWidth: 3,
                      isStrokeCapRound: true,
                      dotData: const FlDotData(show: false),
                      belowBarData: BarAreaData(
                        show: true,
                        color: instagramColor.withAlpha(0x1A),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildAppSavedTime('TikTok', totalTiktok, tiktokColor),
                _buildAppSavedTime('Twitter', totalTwitter, twitterColor),
                _buildAppSavedTime('Instagram', totalInstagram, instagramColor),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAppSavedTime(String app, double hours, Color color) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              app,
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF2D3142),
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Text(
          '${hours.toStringAsFixed(1)}h',
          style: GoogleFonts.poppins(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}