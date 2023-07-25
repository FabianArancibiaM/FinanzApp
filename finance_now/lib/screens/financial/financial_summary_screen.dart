import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:finance_now/widgets/index.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FinancialSummaryScreen extends StatefulWidget {
  const FinancialSummaryScreen({Key? key}) : super(key: key);

  @override
  State<FinancialSummaryScreen> createState() => _FinancialSummaryScreenState();
}

class _FinancialSummaryScreenState extends State<FinancialSummaryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Resumen del mes'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OverviewSummary(),
            const SizedBox(height: 10),
            FadeInLeft(
              duration: const Duration(milliseconds: 250),
              child: BotonGordo(
                icon: FontAwesomeIcons.book,
                texto: 'Ver detalle',
                color1: Color.fromARGB(255, 105, 119, 245),
                color2: Color.fromARGB(255, 124, 110, 245),
                onPress: () {
                  Navigator.pushNamed(context, 'details-financial');
                },
              ),
            ),
            const PieChartSumary()
          ],
        ),
      ),
    );
  }
}
