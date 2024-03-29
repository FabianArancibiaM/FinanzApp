import 'package:flutter/material.dart';
import 'package:under_finance/model/category_model.dart';
import 'package:under_finance/model/type_movement_model.dart';
import 'package:under_finance/provider/category_provider.dart';
import 'package:provider/provider.dart';
import 'package:under_finance/provider/type_movement_provider.dart';

class RoundedButtons extends StatefulWidget {
  const RoundedButtons({super.key});

  @override
  _RoundedButtonsState createState() => _RoundedButtonsState();
}

class _RoundedButtonsState extends State<RoundedButtons> {
  final Color buttonDisable = const Color.fromRGBO(214, 214, 214, 1);
  final Color buttonAdd = Colors.green;
  final Color buttonRemove = Colors.red;

  Color right = const Color.fromRGBO(214, 214, 214, 1);
  Color lefth = const Color.fromRGBO(214, 214, 214, 1);

  int btnSelected = 0;
  late TypeMovementModel categorySelected;

  @override
  Widget build(BuildContext context) {
    final category = context.watch<TypeMovementProvider>();
    print(category.list);
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedButton(
          label: 'Botón 1',
          color: lefth,
          right: false,
          onPressed: () {
            setState(() {
              btnSelected = 1;
              lefth = buttonAdd;
              right = buttonDisable;
              categorySelected = category.list[0];
            });
          },
        ),
        RoundedButton(
          label: 'Botón 2',
          color: right,
          right: true,
          onPressed: () {
            setState(() {
              btnSelected = 2;
              right = buttonRemove;
              lefth = buttonDisable;
              categorySelected = category.list[1];
            });
          },
        ),
      ],
    );
  }
}

class RoundedButton extends StatelessWidget {
  final String label;
  final Color color;
  final VoidCallback onPressed;
  final bool right;

  const RoundedButton({
    required this.label,
    required this.color,
    required this.onPressed,
    required this.right,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: right == true
              ? const BorderRadius.only(
                  topRight: Radius.circular(20.0),
                  bottomRight: Radius.circular(20.0),
                )
              : const BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  bottomLeft: Radius.circular(20.0),
                ),
        ),
        child: right == true
            ? const Icon(Icons.remove_circle_outline)
            : const Icon(Icons.add_circle_outline),
      ),
    );
  }
}
