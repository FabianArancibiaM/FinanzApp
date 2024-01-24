import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:under_finance/components/dropdown_custom.dart';
import 'package:under_finance/components/rounde_buttons.dart';
import 'package:under_finance/components/table_add.dart';

class AddMovementScreen extends StatefulWidget {
  const AddMovementScreen({Key? key}) : super(key: key);

  @override
  State<AddMovementScreen> createState() => _AddMovementScreenState();
}

class _AddMovementScreenState extends State<AddMovementScreen> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final onPrimary = Theme.of(context).colorScheme.onPrimary;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Form(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              const SizedBox(
                height: 80,
              ),
              TextField(
                style: TextStyle(color: onPrimary),
                decoration: InputDecoration(
                  labelText: 'Description',
                  labelStyle: TextStyle(color: onPrimary),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextField(
                style: TextStyle(color: onPrimary),
                decoration: InputDecoration(
                  labelText: 'Monto',
                  labelStyle: TextStyle(color: onPrimary),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: DropdownCustom(),
              //     ), // Espaciado entre los widgets
              //     Expanded(
              //       child: RoundedButtons(),
              //     ),
              //   ],
              // ),
              const DropdownCustom(),
              const SizedBox(
                height: 10,
              ),
              RoundedButtons(),
              const SizedBox(
                height: 10,
              ),
              TableAdd()
            ],
          ),
        ),
      ),
    );
  }
}

// DropdownMenuEntry labels and values for the first dropdown menu.
enum ColorLabel {
  blue('Blue', Color.fromARGB(255, 4, 70, 125)),
  pink('Pink', Colors.pink),
  green('Green', Colors.green),
  yellow('Orange', Colors.orange),
  grey('Grey', Colors.grey);

  const ColorLabel(this.label, this.color);
  final String label;
  final Color color;
}

// DropdownMenuEntry labels and values for the second dropdown menu.
enum IconLabel {
  smile('Smile', Icons.sentiment_satisfied_outlined),
  cloud(
    'Cloud',
    Icons.cloud_outlined,
  ),
  brush('Brush', Icons.brush_outlined),
  heart('Heart', Icons.favorite);

  const IconLabel(this.label, this.icon);
  final String label;
  final IconData icon;
}
