import 'package:animate_do/animate_do.dart';
import 'package:finance_now/widgets/index.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

class OverviewSummary extends StatelessWidget {
  const OverviewSummary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int amountBalance = 0;
    int amountExpenses = 0;
    // final financialProvider = Provider.of<FinancialMovement>(context);
    // final all = financialProvider.list;

    // if (all.isNotEmpty) {
    //   for (var element in all) {
    //     if (element.type == 'A') {
    //       amountBalance = amountBalance + element.ammount;
    //     } else {
    //       amountExpenses = amountExpenses + element.ammount;
    //     }
    //   }
    //   amountBalance = amountBalance - amountExpenses;
    // }

    final formattedBalance = NumberFormat.currency(
      locale: 'es_CL',
      symbol: '',
      decimalDigits: 0,
    ).format(amountBalance);

    return FadeInLeft(
        duration: const Duration(milliseconds: 250),
        child: BotonGordo(
          icon: FontAwesomeIcons.piggyBank,
          texto: 'Disponible \n \$$formattedBalance',
          color1: const Color(0xffF2D572),
          color2: const Color(0xffE06AA3),
          modeButton: false,
          onPress: () {},
        ));
  }
}
