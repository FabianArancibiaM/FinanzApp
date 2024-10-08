import 'package:flutter/material.dart';
import 'package:up_finance/widget/structure/body.widget.dart';
import 'package:up_finance/widget/structure/footer.widget.dart';
import 'package:up_finance/widget/structure/header.widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: SafeArea(
            child: Column(
      children: [
        //HeaderWidget(),
        BodyWidget(), FooterWidget()
      ],
    )));
  }
}
