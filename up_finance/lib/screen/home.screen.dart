import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:up_finance/providers/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future test(ParametricDataProvider categoryProvider) async {
    await categoryProvider.getParametricData('');
  }

  @override
  void initState() {
    super.initState();
    // Ejecutar la función una sola vez en initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final categoryProvider =
          Provider.of<ParametricDataProvider>(context, listen: false);
      test(categoryProvider);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(30.0),
            child: Column(
              children: <Widget>[
                Summary(),
                CardToGo(),
              ],
            ),
          ),
        )
      ],
    )));
  }
}

class CardToGo extends StatelessWidget {
  const CardToGo({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Colors.cyanAccent,
        onTap: () => {Navigator.pushNamed(context, 'addTrx')},
        child: SizedBox(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  'assets/icons/transaccion.png',
                  width: 50,
                  height: 50,
                ),
                Text('Agregar Transacción'),
                Image.asset(
                  'assets/icons/flecha_derecha.png',
                  width: 50,
                  height: 50,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class Summary extends StatelessWidget {
  const Summary({super.key});

  @override
  Widget build(BuildContext context) {
    return const Card(
        child: SizedBox(
      height: 160,
      width: 500,
      child: Padding(
        padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Saldo Actual', style: TextStyle(fontSize: 14))),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '\$125.000',
                style: TextStyle(fontSize: 30),
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Ingresos:',
                ),
                Text(
                  '\$200.000.-',
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Gastos:',
                ),
                Text(
                  '\$50.000.-',
                ),
              ],
            ),
          ],
        ),
      ),
    ));
  }
}
