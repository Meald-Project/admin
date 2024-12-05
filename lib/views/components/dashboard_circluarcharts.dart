import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class CircularCharts extends StatelessWidget {
  const CircularCharts({super.key});

  @override
  Widget build(BuildContext context) {
    // Define the values for the chart sections
    const double totalValue = 40 + 30 + 20; // Sum of all values
    final double clientsPercentage = (40 / totalValue) * 100;
    final double restaurantsPercentage = (30 / totalValue) * 100;
    final double livreursPercentage = (20 / totalValue) * 100;

    return Container(
      height: 350, // Adjusted height to accommodate the title
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Align title to the start
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0), // Add padding for the title
            child: Text(
              'Statistique des utilisateurs',
              style: TextStyle(
                fontSize: 18, // Adjust font size as needed
                fontWeight: FontWeight.bold, // Make it bold
              ),
            ),
          ),
          Expanded( // Makes the PieChart take up the remaining space
            child: PieChart(
              PieChartData(
                sections: [
                  PieChartSectionData(
                    value: 40,
                    color: Colors.blue,
                    title: '${clientsPercentage.toStringAsFixed(1)}%\nClients', // Percentage and category name
                    radius: 100,
                    titleStyle: const TextStyle(
                      color: Colors.white, // White text color
                      fontSize: 14, // Adjust font size as needed
                      fontWeight: FontWeight.bold,
                      height: 1.2, // Adjust line height for better spacing
                    ),
                  ),
                  PieChartSectionData(
                    value: 30,
                    color: Colors.red,
                    title: '${restaurantsPercentage.toStringAsFixed(1)}%\nRestaurants', // Percentage and category name
                    radius: 100,
                    titleStyle: const TextStyle(
                      color: Colors.white, // White text color
                      fontSize: 14, // Adjust font size as needed
                      fontWeight: FontWeight.bold,
                      height: 1.2, // Adjust line height for better spacing
                    ),
                  ),
                  PieChartSectionData(
                    value: 20,
                    color: Colors.green,
                    title: '${livreursPercentage.toStringAsFixed(1)}%\nLivreurs', // Percentage and category name
                    radius: 100,
                    titleStyle: const TextStyle(
                      color: Colors.white, // White text color
                      fontSize: 14, // Adjust font size as needed
                      fontWeight: FontWeight.bold,
                      height: 1.2, // Adjust line height for better spacing
                    ),
                  ),
                ],
                borderData: FlBorderData(show: false),
                sectionsSpace: 0, // No space between sections
              ),
            ),
          ),
        ],
      ),
    );
  }
}
