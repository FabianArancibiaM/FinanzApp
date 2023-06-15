import 'package:finance_now/widgets/expanded_form.dart';
import 'package:finance_now/widgets/graphics/table_summary.dart';
import 'package:flutter/material.dart';
import 'package:finance_now/widgets/design/auth_background.dart';
import 'package:finance_now/widgets/design/card_container.dart';

class FormScreen extends StatefulWidget {
  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulario'),
      ),
      body: const AuthBackground(
          child: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 10),
            CardContainer(
              child: Column(children: [ExpandedForm()]),
            ),
            SizedBox(height: 10),
            TableSummary()
          ],
        ),
      )),
    );
  }
}
