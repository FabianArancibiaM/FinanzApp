import 'package:finance_now/providers/csv_generate.dart';
import 'package:finance_now/providers/financial_movement.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final financialProvider = Provider.of<FinancialMovement>(context);
    final colors = Theme.of(context).colorScheme.primary;

    var showSpinner = false;

    return Scaffold(
      body: Stack(children: [
        Visibility(
          visible: showSpinner,
          child: Center(
              child: Container(
            margin: const EdgeInsets.only(top: 250),
            child: CircularProgressIndicator(
              strokeWidth: 8,
              valueColor: AlwaysStoppedAnimation<Color>(colors),
            ),
          )),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/images/logo.png', // Ruta de la imagen
                width: 150,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  showSpinner = true;
                  financialProvider
                      .loadDataUser()
                      .then((value) => Navigator.pushNamed(context, 'menu'));
                },
                child: Text('Botón'),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  CsvGenerate().main();
                },
                child: Text('CSV'),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
