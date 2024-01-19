import 'package:flutter/material.dart';

class AddMovementScreen extends StatefulWidget {
  const AddMovementScreen({Key? key}) : super(key: key);

  @override
  State<AddMovementScreen> createState() => _AddMovementScreenState();
}

class _AddMovementScreenState extends State<AddMovementScreen> {
  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final background = Theme.of(context).colorScheme.secondary;
    final List<String> items = ['Opción 1', 'Opción 2', 'Opción 3'];
    String selectedValue = 'Opción 1';
    return Form(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(
              height: 80,
            ),
            TextField(
              style: TextStyle(color: primaryColor),
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(color: primaryColor),
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
              style: TextStyle(color: primaryColor),
              decoration: InputDecoration(
                labelText: 'Value',
                labelStyle: TextStyle(color: primaryColor),
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
              style: TextStyle(color: primaryColor),
              decoration: InputDecoration(
                labelText: 'Value',
                labelStyle: TextStyle(color: primaryColor),
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
              style: TextStyle(color: primaryColor),
              decoration: InputDecoration(
                labelText: 'Value',
                labelStyle: TextStyle(color: primaryColor),
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
            DropdownButtonFormField<String>(
              value: selectedValue,
              dropdownColor: background,
              style: TextStyle(color: primaryColor),
              focusColor: background,
              decoration: InputDecoration(
                filled: true,
                fillColor: background, // Color de fondo del listado
                labelText: 'Selecciona una opción',
                labelStyle: TextStyle(color: primaryColor),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: primaryColor),
                ),
              ),
              items: items.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: primaryColor),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  // Actualizar el valor seleccionado
                  selectedValue = newValue;
                  // Realizar acciones según la selección
                  print('Opción seleccionada: $newValue');
                }
              },
            ),
            const SizedBox(
              height: 10,
            )
          ],
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
