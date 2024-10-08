import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  const CustomCard({required this.cardName, required this.router});
  final String cardName;
  final String router;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 100,
      child: Center(
          child: TextButton(
              onPressed: () {
                Navigator.pushNamed(context, router);
              },
              child: Text(cardName))),
    );
  }
}
