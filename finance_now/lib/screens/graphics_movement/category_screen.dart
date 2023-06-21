import 'package:finance_now/widgets/graphics/bar_chart_category.dart';
import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categoria'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BarChartCategory(),
      ),
    );
  }
}
