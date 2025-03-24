import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';

class WeeklyProgressChart extends StatelessWidget {
  const WeeklyProgressChart({super.key});

  // Color scheme
  static const Color _primaryColor = Color(0xFFFF6B6B);
  static const Color _secondaryColor = Color(0xFFFFD166);
  static const Color _textColor = Color(0xFF2D3142);
  static const Color _lightTextColor = Color(0xAA2D3142);
  static const Color _borderColor = Color(0xFFEAEAEA);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 340,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 16,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            Expanded(child: _buildChart()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Weekly Progress',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: _textColor,
          ),
        ),
        _buildLegend(),
      ],
    );
  }

  Widget _buildLegend() {
    return Row(
      children: [
        _legendItem(_primaryColor, 'This Week'),
        const SizedBox(width: 12),
        _legendItem(_secondaryColor, 'Last Week'),
      ],
    );
  }

  Widget _legendItem(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 12,
            color: _lightTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildChart() {
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          horizontalInterval: 2,
          getDrawingHorizontalLine: (value) {
            return FlLine(
              color: _borderColor,
              strokeWidth: 1,
              dashArray: [4, 4],
            );
          },
        ),
        titlesData: _buildTitles(),
        borderData: FlBorderData(
          show: true,
          border: Border(
            bottom: BorderSide(color: _borderColor, width: 1),
            left: BorderSide(color: _borderColor, width: 1),
          ),
        ),
        lineTouchData: _buildTouchData(),
        lineBarsData: [
          _buildLineData(_primaryColor, [
            const FlSpot(0, 3),
            const FlSpot(1, 4),
            const FlSpot(2, 3.5),
            const FlSpot(3, 5),
            const FlSpot(4, 4.5),
            const FlSpot(5, 6),
            const FlSpot(6, 5.5),
          ]),
          _buildLineData(_secondaryColor, [
            const FlSpot(0, 2),
            const FlSpot(1, 3),
            const FlSpot(2, 2.5),
            const FlSpot(3, 4),
            const FlSpot(4, 3.5),
            const FlSpot(5, 5),
            const FlSpot(6, 4.5),
          ]),
        ],
        minX: 0,
        maxX: 6,
        minY: 0,
        maxY: 7,
      ),
    );
  }

  FlTitlesData _buildTitles() {
    return FlTitlesData(
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 24,
          getTitlesWidget: (value, meta) {
            final weekdays = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
            final index = value.toInt();
            
            if (index < 0 || index >= weekdays.length) return const SizedBox.shrink();
            
            return Text(
              weekdays[index],
              style: GoogleFonts.poppins(
                color: _lightTextColor,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
      ),
      leftTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 24,
          interval: 2,
          getTitlesWidget: (value, meta) {
            if (value == 0) return const SizedBox.shrink();
            
            return Text(
              value.toInt().toString(),
              style: GoogleFonts.poppins(
                color: _lightTextColor,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            );
          },
        ),
      ),
    );
  }

  LineTouchData _buildTouchData() {
    return LineTouchData(
      enabled: true,
      touchTooltipData: LineTouchTooltipData(
        getTooltipColor: (_) => Colors.white,
        tooltipRoundedRadius: 8,
        tooltipPadding: const EdgeInsets.all(8),
        tooltipBorder: BorderSide(color: _borderColor, width: 1),
        getTooltipItems: (touchedSpots) {
          final weekdays = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
          
          return touchedSpots.map((spot) {
            final weekdayIndex = spot.x.toInt();
            final weekday = (weekdayIndex >= 0 && weekdayIndex < weekdays.length) 
                ? weekdays[weekdayIndex] 
                : '';
                
            return LineTooltipItem(
              '${spot.y.toStringAsFixed(1)} hrs\n$weekday',
              GoogleFonts.poppins(
                color: spot.bar.color,
                fontWeight: FontWeight.w500,
                fontSize: 12,
              ),
            );
          }).toList();
        },
      ),
      handleBuiltInTouches: true,
    );
  }

  LineChartBarData _buildLineData(Color color, List<FlSpot> spots) {
    return LineChartBarData(
      spots: spots,
      isCurved: true,
      color: color,
      barWidth: 2.5,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: true,
        getDotPainter: (spot, percent, barData, index) {
          return FlDotCirclePainter(
            radius: 3,
            color: Colors.white,
            strokeWidth: 1.5,
            strokeColor: color,
          );
        },
      ),
      belowBarData: BarAreaData(
        show: true,
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.2),
            color.withOpacity(0.0),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}