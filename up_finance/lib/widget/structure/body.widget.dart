import 'package:flutter/material.dart';

class BodyWidget extends StatelessWidget {
  const BodyWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          children: <Widget>[
            Container(
              color: Colors.red,
              height: 200.0,
              alignment: Alignment.center,
              child: Text("Content 1"),
            ),
            Container(
              color: Colors.green,
              height: 300.0,
              alignment: Alignment.center,
              child: Text("Content 1"),
            ),
            //TextField nearly at bottom
            TextField(
              decoration: InputDecoration(hintText: "Enter Text Here"),
            ),
          ],
        ),
      ),
    );
  }
}
