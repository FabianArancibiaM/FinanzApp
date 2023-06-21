import 'package:finance_now/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class GraphicsScreen extends StatelessWidget {
  GraphicsScreen({Key? key}) : super(key: key);

  final List<charts.Series<dynamic, String>> seriesList = [
    charts.Series<dynamic, String>(
      id: 'Sales',
      data: [
        {'year': '2017', 'sales': 500},
        {'year': '2018', 'sales': 800},
        {'year': '2019', 'sales': 1000},
        {'year': '2020', 'sales': 1200},
      ],
      domainFn: (dynamic sales, _) => sales['year'] as String,
      measureFn: (dynamic sales, _) => sales['sales'] as int,
    ),
  ];

  final List<charts.Series<dynamic, int>> lineSeriesList = [
    charts.Series<dynamic, int>(
      id: 'Sales',
      data: [
        {'year': '2017', 'sales': 500},
        {'year': '2018', 'sales': 800},
        {'year': '2019', 'sales': 1000},
        {'year': '2020', 'sales': 1200},
      ],
      domainFn: (dynamic sales, _) => int.parse(sales['year']),
      measureFn: (dynamic sales, _) => sales['sales'] as int,
    ),
  ];

  final List<charts.Series<dynamic, String>> pieSeriesList = [
    charts.Series<dynamic, String>(
      id: 'Sales',
      data: [
        {'year': '2017', 'sales': 500},
        {'year': '2018', 'sales': 800},
        {'year': '2019', 'sales': 1000},
        {'year': '2020', 'sales': 1200},
      ],
      domainFn: (dynamic sales, _) => sales['year'] as String,
      measureFn: (dynamic sales, _) => sales['sales'] as int,
      labelAccessorFn: (dynamic sales, _) =>
          '${sales['year']}: ${sales['sales']}',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Charts Screen'),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 200,
                child: Expanded(
                  child: charts.BarChart(
                    seriesList,
                    animate: true,
                  ),
                ),
              ),
              Container(
                height: 150,
                width: 200,
                child: Expanded(
                  child: charts.LineChart(
                    lineSeriesList,
                    animate: true,
                  ),
                ),
              ),
              Container(
                height: 150,
                width: 200,
                child: Expanded(
                  child: BarChartSummary(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SalesData {
  final String year;
  final int sales;

  SalesData({required this.year, required this.sales});
}
