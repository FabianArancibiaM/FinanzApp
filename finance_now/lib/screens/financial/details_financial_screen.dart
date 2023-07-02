import 'package:finance_now/widgets/index.dart';
import 'package:flutter/material.dart';

class DetailsFinancialScreen extends StatelessWidget {
  const DetailsFinancialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del periodo actual'),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            OverviewSummary(),
            MovementSummary(),
          ],
        ),
      ),
    );
  }
}
