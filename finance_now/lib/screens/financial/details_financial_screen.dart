import 'package:animate_do/animate_do.dart';
import 'package:finance_now/widgets/index.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailsFinancialScreen extends StatelessWidget {
  const DetailsFinancialScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalle del periodo actual'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const OverviewSummary(),
            FadeInLeft(
              duration: const Duration(milliseconds: 250),
              child: BotonGordo(
                icon: FontAwesomeIcons.circlePlus,
                texto: 'Nuevo movimiento',
                color1: Color.fromARGB(255, 105, 245, 180),
                color2: Color.fromARGB(255, 160, 245, 110),
                onPress: () {
                  Navigator.pushNamed(context, 'form-mevement');
                },
              ),
            ),
            const MovementSummary(),
          ],
        ),
      ),
    );
  }
}
