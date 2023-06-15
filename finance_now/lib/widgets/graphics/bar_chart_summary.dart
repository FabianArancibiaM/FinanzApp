import 'package:finance_now/providers/financial_movement.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:provider/provider.dart';

class BarChartSummary extends StatelessWidget {
  final List<String> categories = ['1ra', '2da', '3a', '4ta', '5ta'];

  BarChartSummary({super.key});

  _mappingDataView(FinancialMovement financialMovement) async {
    final List<double> values1 = [];
    final List<double> values2 = [];
    final list = await financialMovement.listToPeriod();
    var green = 0;
    var red = 0;
    for (var value in list) {
      if (value.type == 'A') {
        green = green + value.ammount;
      } else {
        red = red + value.ammount;
      }
    }
    values1.add(double.parse(green.toString()));
    values2.add(double.parse(red.toString()));
    return [values1, values2];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FinancialMovement>(
        builder: (context, financialProvider, _) {
      final update = _mappingDataView(financialProvider);
      final values1 = update[0];
      final values2 = update[1];
      return Container(
        height: 300,
        padding: const EdgeInsets.all(16.0),
        child: BarChart(
          BarChartData(
            barGroups: List.generate(
              categories.length,
              (index) => BarChartGroupData(
                x: index,
                barRods: [
                  BarChartRodData(
                    toY: values1.isEmpty ? 0 : values1[index],
                    color: const Color.fromARGB(255, 32, 186, 37),
                    width: 16,
                  ),
                  BarChartRodData(
                    toY: values2.isEmpty ? 0 : values2[index],
                    color: const Color.fromARGB(255, 234, 32, 18),
                    width: 16,
                  ),
                ],
              ),
            ),
            titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                  showTitles: true,
                  getTitlesWidget: (value, meta) {
                    int index = value.toInt();
                    if (index >= 0 && index < categories.length) {
                      return Text(categories[index]);
                    }
                    return Text('');
                  },
                ))),
            borderData: FlBorderData(
              show: true,
              border: Border.all(
                color: Colors.black,
                width: 1,
              ),
            ),
            barTouchData: BarTouchData(
              enabled: false,
            ),
            gridData: FlGridData(
              show: true,
              drawHorizontalLine: true,
              drawVerticalLine: true,
              checkToShowHorizontalLine: (double value) => value % 100 == 0,
              checkToShowVerticalLine: (double value) => value % 1 == 0,
            ),
          ),
        ),
      );
    });
  }
}
