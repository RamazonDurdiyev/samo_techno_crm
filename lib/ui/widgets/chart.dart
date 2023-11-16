import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:samo_techno_crm/ui/pages/statistics_page/statistics_page.dart';

class DynamicChart extends StatelessWidget {
  DynamicChart({
    super.key,
  });

  final List<String> daysOfWeek = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun'
  ];

  @override
  Widget build(BuildContext context) {
    // Get the current day (0 for Monday, 1 for Tuesday, ..., 6 for Sunday).
    int currentDay = DateTime.now().weekday - 1;

    // Create a list of days that starts with the current day and wraps around.
    List<String> reorderedDaysOfWeek = List<String>.generate(7, (index) {
      return daysOfWeek[(currentDay + index) % 7];
    });

    // Move the current day to the last position in the list.
    String today = reorderedDaysOfWeek.removeAt(0);
    reorderedDaysOfWeek.add(today);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const StatisticsPage();
              },
            ),
          );
        },
        child: Card(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(16),
            ),
          ),
          elevation: 2,
          child: Column(
            children: [
              const SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                height: 100,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(
                      16,
                    ),
                  ),
                ),
                child: LineChart(
                  LineChartData(
                    lineTouchData: const LineTouchData(enabled: false),
                    gridData: const FlGridData(show: false),
                    titlesData: const FlTitlesData(show: false),
                    borderData: FlBorderData(
                      show: false,
                      border: Border.all(
                        color: const Color(0xff37434d),
                        width: 1,
                      ),
                    ),
                    minX: 0,
                    maxX: 6,
                    minY: 0,
                    maxY: 10,
                    lineBarsData: [
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 9),
                          const FlSpot(1, 4),
                          const FlSpot(2, 10),
                          const FlSpot(3, 2),
                          const FlSpot(4, 4),
                          const FlSpot(5, 4),
                          const FlSpot(6, 4),
                        ],
                        isCurved: true,
                        color: Colors.red,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.red.withOpacity(0.1),
                        ),
                      ),
                      LineChartBarData(
                        spots: [
                          const FlSpot(0, 4),
                          const FlSpot(1, 4),
                          const FlSpot(2, 4),
                          const FlSpot(3, 7),
                          const FlSpot(4, 6),
                          const FlSpot(5, 7),
                          const FlSpot(6, 8),
                        ],
                        isCurved: true,
                        color: Colors.green,
                        dotData: const FlDotData(show: false),
                        belowBarData: BarAreaData(
                          show: true,
                          color: Colors.green.withOpacity(0.1),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: reorderedDaysOfWeek
                    .map(
                      (day) => _buildWeeksText(day),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeeksText(String day) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        day,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
