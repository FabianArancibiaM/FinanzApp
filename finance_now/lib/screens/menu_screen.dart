import 'package:finance_now/providers/financial_movement.dart';
import 'package:flutter/material.dart';

import 'package:animate_do/animate_do.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../widgets/index.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = <ItemBoton>[
      ItemBoton(FontAwesomeIcons.handHoldingDollar, 'Rendimiento Financiero',
          const Color(0xff6989F5), const Color(0xff906EF5), 'financial-sumary'),
      ItemBoton(FontAwesomeIcons.sackDollar, 'Agregar Movimiento',
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
      body: Stack(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 200),
            child: ListView(
              physics: BouncingScrollPhysics(),
              children: <Widget>[
                SizedBox(
                  height: 80,
                ),
                ...itemMap
              ],
            ),
          ),
          _Encabezado()
        ],
      ),
    );
  }
}

class _Encabezado extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        IconHeader(
          icon: FontAwesomeIcons.moneyBill1,
          titulo: 'Bienvenid@',
          subtitulo: 'Tus finanzas',
          color1: Color(0xff536CF6),
          color2: Color(0xff66A9F2),
        ),
        Positioned(
            right: 0,
            top: 45,
            child: RawMaterialButton(
                onPressed: () {
                  Navigator.pushNamed(context, 'home');
                },
                shape: CircleBorder(),
                padding: EdgeInsets.all(15.0),
                child: FaIcon(FontAwesomeIcons.rightFromBracket,
                    color: Colors.white)))
      ],
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
