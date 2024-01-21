import 'package:flutter/material.dart';

class RoundedButtons extends StatefulWidget {
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

  @override
  Widget build(BuildContext context) {
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
