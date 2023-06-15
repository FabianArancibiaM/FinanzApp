import 'package:finance_now/providers/financial_movement.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PieChartSumary extends StatelessWidget {
  const PieChartSumary({Key? key}) : super(key: key);

  static List<ChartData> createData(FinancialMovement financialProvider) {
    final list = financialProvider.list;
    double green = 0;
    double yellow = 0;
    double red = 0;
    for (var value in list) {
      if (value.type == 'A') {
        green = green + value.ammount;
      } else {
        red = red + value.ammount;
      }
    }

    green = green - red;
    if (green < 0) {
      yellow = green * -1;
      green = 1;
    }

    var data = [
      ChartData('Gastos', red, Colors.red),
      ChartData('Disponible', green, Colors.green),
      // ChartData('Segmento 4', 35, Colors.orange),
    ];
    yellow > 0
        ? data.add(ChartData('Sobre girado', yellow, Colors.yellow))
        : null;
    return data;
  }

  String formatValue(double value) {
    if (value == 1) {
      return '\$0';
    }
    final formattedBalance = NumberFormat.currency(
      locale: 'es_CL',
      symbol: '',
      decimalDigits: 0,
    ).format(value);
    return '\$$formattedBalance';
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FinancialMovement>(
        builder: (context, financialProvider, _) {
      final list = financialProvider.getAllMovementMonth();
      if (list.isEmpty) {
        return Container();
      }
      return Container(
        child: AspectRatio(
          aspectRatio: 1,
          child: SfCircularChart(
            series: <CircularSeries>[
              PieSeries<ChartData, String>(
                dataSource: createData(financialProvider),
                xValueMapper: (ChartData data, _) => data.segment,
                yValueMapper: (ChartData data, _) => data.value,
                pointColorMapper: (ChartData data, _) => data.color,
                explode: true,
                explodeAll: true,
                explodeOffset: '1%',
                dataLabelMapper: (ChartData data, _) =>
                    data.segment + '\n' + formatValue(data.value),
                dataLabelSettings: const DataLabelSettings(
                  isVisible: true,
                  textStyle: TextStyle(fontSize: 20),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class ChartData {
  final String segment;
  final double value;
  final Color color;

  ChartData(this.segment, this.value, this.color);
}
