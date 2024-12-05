import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class MainChart extends StatelessWidget {
  final String selectedPeriod;
  final List<FlSpot> chartData;
  final Function(String) onPeriodChanged;

  MainChart({
    required this.selectedPeriod,
    required this.chartData,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Get the screen width to adjust text size for smaller screens
    final screenWidth = MediaQuery.of(context).size.width;
    // Adjusting the button text size based on screen width
    final buttonTextStyle = TextStyle(
      fontSize: screenWidth < 350 ? 8 : (screenWidth < 500 ? 12 : 14), // Smaller text on narrow screens
      color: Colors.black,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Period selection buttons
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ['Today', 'Last Week', 'Last Month', 'Last Year'].map((period) {
            return Flexible(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 4.0),
                child: ElevatedButton(
                  onPressed: () => onPeriodChanged(period),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedPeriod == period ? Colors.green : Colors.grey[300],
                    elevation: 4,

                    fixedSize: Size.fromHeight(40), // Set a fixed height
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(period, style: buttonTextStyle),
                ),
              ),
            );
          }).toList(),
        ),
        SizedBox(height: 16),
        Container(
          height: 300,
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                spreadRadius: 2,
                blurRadius: 6,
              ),
            ],
          ),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawHorizontalLine: true,
                drawVerticalLine: false,
              ),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                ),
                rightTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(
                show: true,
                border: Border(
                  left: BorderSide(color: Colors.black, width: 2),
                  bottom: BorderSide(color: Colors.black, width: 2),
                  right: BorderSide.none,
                  top: BorderSide.none,
                ),
              ),
              lineBarsData: [
                LineChartBarData(
                  spots: chartData,
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.lightBlueAccent],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  isCurved: true,
                  dotData: FlDotData(
                    show: true,
                    checkToShowDot: (spot, _) => true,
                  ),
                  belowBarData: BarAreaData(show: false),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
