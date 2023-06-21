import 'package:finance_now/widgets/index.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GraphicsScreen extends StatelessWidget {
  const GraphicsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final items = <ItemBoton>[
      ItemBoton(
          FontAwesomeIcons.chartColumn,
          'Gategorias',
          const Color(0xff6989F5),
          const Color(0xff906EF5),
          'graphics-category'),
      ItemBoton(FontAwesomeIcons.chartLine, 'Ultimos 5 periodos',
          const Color(0xff317183), const Color(0xff46997D), 'form-mevement'),
    ];

    List<Widget> itemMap = items
        .map((item) => FadeInLeft(
              duration: const Duration(milliseconds: 250),
              child: BotonGordo(
                icon: item.icon,
                texto: item.texto,
                color1: item.color1,
                color2: item.color2,
                onPress: () {
                  Navigator.pushNamed(context, item.widgetTo);
                },
              ),
            ))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Graficos'),
      ),
      body: Stack(
        children: <Widget>[
          ListView(
            physics: const BouncingScrollPhysics(),
            children: <Widget>[const SizedBox(height: 80), ...itemMap],
          ),
        ],
      ),
    );
  }
}

class ItemBoton {
  final IconData icon;
  final String texto;
  final Color color1;
  final Color color2;
  final String widgetTo;

  ItemBoton(this.icon, this.texto, this.color1, this.color2, this.widgetTo);
}
