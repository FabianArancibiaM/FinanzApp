import 'package:finance_now/providers/financial_movement.dart';
import 'package:finance_now/shared/index.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BarChartCategory extends StatelessWidget {
  BarChartCategory({Key? key}) : super(key: key);

  final List<SelectorObject> listType = InfoConst().listType;

  final List<SelectorObject> listCategory = InfoConst().listCategory;

  @override
  Widget build(BuildContext context) {
    late List<_ChartData> data;
    late List<_ChartData> data2;
    late TooltipBehavior _tooltip;
    data = [];
    data2 = [];
    _tooltip = TooltipBehavior(enable: true);
    var maxAmount = 0;

    return Consumer<FinancialMovement>(
        builder: (context, financialProvider, _) {
      final listPeriod = financialProvider.list;
      if (listPeriod.isNotEmpty) {
        for (var element in listPeriod) {
          var category =
              listCategory.where((data) => data.key == element.category);
          if (element.type == 'A') {
            data.add(_ChartData(
                category.first.value, element.ammount.toDouble(), '1s'));
          } else {
            data2.add(_ChartData(
                category.first.value, element.ammount.toDouble(), '1s'));
          }
          if (maxAmount < element.ammount) {
            maxAmount = element.ammount;
          }
        }
      }

      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Expanded(
          child: SfCartesianChart(
              primaryXAxis: CategoryAxis(),
              primaryYAxis: NumericAxis(
                  minimum: 1000,
                  maximum: maxAmount.toDouble(),
                  interval: 100000,
                  numberFormat: NumberFormat.currency(
                    locale: 'es_CL',
                    symbol: '',
                    decimalDigits: 0,
                  )),
              tooltipBehavior: _tooltip,
              series: <ChartSeries<_ChartData, String>>[
                ColumnSeries<_ChartData, String>(
                    dataSource: data,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    name: 'Categoria',
                    color: Color.fromRGBO(186, 41, 25, 1)),
                ColumnSeries<_ChartData, String>(
                    dataSource: data2,
                    xValueMapper: (_ChartData data, _) => data.x,
                    yValueMapper: (_ChartData data, _) => data.y,
                    name: 'Categoria',
                    color: Color(0xFF24C11E))
              ]),
        ),
      );
    });
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.name);

  final String x;
  final double y;
  final String name;
}
