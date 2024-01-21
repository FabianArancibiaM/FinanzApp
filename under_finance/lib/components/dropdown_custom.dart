import 'package:flutter/material.dart';

class DropdownCustom extends StatefulWidget {
  const DropdownCustom({Key? key}) : super(key: key);

  @override
  State<DropdownCustom> createState() => _DropdownCustomState();
}

class _DropdownCustomState extends State<DropdownCustom> {
  @override
  Widget build(BuildContext context) {
    final List<ItemCustom> items = [
      new ItemCustom(
        icns: Icons.abc_rounded,
        txt: 'Option 1',
      ),
      new ItemCustom(
        icns: Icons.access_alarm_outlined,
        txt: 'Option 2',
      ),
      new ItemCustom(
        icns: Icons.account_balance_wallet_sharp,
        txt: 'Option 3',
      ),
      new ItemCustom(
        icns: Icons.account_circle,
        txt: 'Option 4',
      ),
      new ItemCustom(
        icns: Icons.add_card_sharp,
        txt: 'Option 5',
      )
    ];
    ItemCustom selectedValue = items[0];
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    final primary = Theme.of(context).colorScheme.primary;
    final background = Theme.of(context).colorScheme.background;
    return DropdownButtonFormField<ItemCustom>(
      value: selectedValue,
      dropdownColor: background,
      style: TextStyle(color: onPrimary),
      focusColor: background,
      decoration: InputDecoration(
        filled: true,
        fillColor: background, // Color de fondo del listado
        labelText: 'Selecciona una opción',
        labelStyle: TextStyle(color: onPrimary),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: primary),
        ),
      ),
      items: items.map((ItemCustom value) {
        return DropdownMenuItem<ItemCustom>(value: value, child: value);
      }).toList(),
      onChanged: (ItemCustom? newValue) {
        if (newValue != null) {
          // Actualizar el valor seleccionado
          selectedValue = newValue;
          // Realizar acciones según la selección
          print('Opción seleccionada: $newValue');
        }
      },
    );
  }
}

class ItemCustom extends StatelessWidget {
  final IconData icns;
  final String txt;
  const ItemCustom({Key? key, required this.icns, required this.txt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final onPrimary = Theme.of(context).colorScheme.onPrimary;
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          this.icns,
          color: onPrimary,
          size: 40,
        ),
        Text(
          this.txt,
          style: TextStyle(fontSize: 20),
        )
      ]),
    );
  }
}
