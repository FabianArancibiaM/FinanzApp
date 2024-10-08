import 'package:finance_v3/widget/design/custom_card.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Card(
                child: CustomCard(
              cardName: 'Ir al menú',
              router: 'menu',
            )),
          ],
        ),
      ),
    );
  }
}
