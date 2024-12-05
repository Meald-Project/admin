import 'package:flutter/material.dart';

class StatisticBoxes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 12),
        Text(
          "Bonjour cher utilisateur!",
          style: TextStyle(
            fontSize: 20, // Adjusted for smaller text
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 16),
        LayoutBuilder(
          builder: (context, constraints) {
            double screenWidth = constraints.maxWidth;
            double fontSize = screenWidth < 360 ? 14 : 18; // Smaller font for value text
            double titleFontSize = screenWidth < 360 ? 10 : 12; // Smaller font for title text
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: _buildStatBox('Visiteurs Du Site', '12K', Colors.blue, fontSize, titleFontSize),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _buildStatBox('Total Revenu', '50K', Colors.green, fontSize, titleFontSize),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _buildStatBox('Total Dépenses', '20K', Colors.red, fontSize, titleFontSize),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: _buildStatBox('Revenu Brut', '30K', Colors.orange, fontSize, titleFontSize),
                ),
              ],
            );
          },
        ),
        SizedBox(height: 10),
      ],
    );
  }

  Widget _buildStatBox(String title, String value, Color color, double fontSize, double titleFontSize) {
    return Container(
      height: 100, // Set a fixed height for uniformity
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 4,
          ),
        ],
      ),
      padding: EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            value,
            style: TextStyle(
              fontSize: fontSize,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 6),
          Text(
            title,
            style: TextStyle(
              fontSize: titleFontSize,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
