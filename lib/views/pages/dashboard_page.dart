import 'package:flutter/material.dart';
import '../components/dashboard_feedbacklist.dart';
import '../components/dashboard_mainchart.dart';
import '../components/dashboard_statisticboxes.dart';
import '../components/dashboard_circluarcharts.dart';
import 'package:fl_chart/fl_chart.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _selectedPeriod = 'Today';
  List<FlSpot> _chartData = [];

  @override
  void initState() {
    super.initState();
    _updateChartData(_selectedPeriod);
  }

  void _updateChartData(String period) {
    switch (period) {
      case 'Today':
        _chartData = [
          const FlSpot(0, 3),
          const FlSpot(1, 4),
          const FlSpot(2, 6),
          const FlSpot(3, 5),
          const FlSpot(4, 7),
        ];
        break;
      case 'Last Week':
        _chartData = [
          const FlSpot(0, 1),
          const FlSpot(1, 2),
          const FlSpot(2, 3),
          const FlSpot(3, 4),
          const FlSpot(4, 5),
        ];
        break;
      case 'Last Month':
        _chartData = [
          const FlSpot(0, 2),
          const FlSpot(1, 3),
          const FlSpot(2, 4),
          const FlSpot(3, 3),
          const FlSpot(4, 6),
        ];
        break;
      case 'Last Year':
        _chartData = [
          const FlSpot(0, 5),
          const FlSpot(1, 6),
          const FlSpot(2, 7),
          const FlSpot(3, 5),
          const FlSpot(4, 4),
        ];
        break;
      default:
        _chartData = [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        bool isSmallScreen = constraints.maxWidth < 600;

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 3,
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    StatisticBoxes(),
                    const SizedBox(height: 16),
                    MainChart(
                      selectedPeriod: _selectedPeriod,
                      chartData: _chartData,
                      onPeriodChanged: (String period) {
                        setState(() {
                          _selectedPeriod = period;
                          _updateChartData(period);
                        });
                      },
                    ),
                    const SizedBox(height: 26),
                    CircularCharts(),
                    if (isSmallScreen) ...[
                      const SizedBox(height: 16),
                      FeedbackSection(),
                    ],
                  ],
                ),
              ),
            ),
            if (!isSmallScreen) ...[
              Expanded(
                flex: 1,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: FeedbackSection(),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
