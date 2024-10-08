import 'package:finance_v3/widget/design/custom_card.dart';
import 'package:flutter/material.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                child: CustomCard(
              cardName: 'Resumen',
              router: 'summary',
            )),
            Card(
                child: CustomCard(
              cardName: 'Agregar Movimiento',
              router: 'add_movement',
            )),
          ],
        ),
      ),
    );
  }
}
