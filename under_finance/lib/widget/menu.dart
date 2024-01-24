import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:under_finance/components/footer_navigator.dart';
import 'package:under_finance/components/header.dart';
import 'package:under_finance/provider/category_provider.dart';
import 'package:under_finance/provider/type_movement_provider.dart';
import 'package:under_finance/widget/add_movement.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        leading: IconButton(
          color: Colors.black,
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(children: [
        const HeaderScreen(),
        Container(
          padding: const EdgeInsets.only(top: 10),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: IndexedStack(
              index: _currentIndex,
              children: const [
                Center(child: Text('Contenido de la pantalla de Business')),
                AddMovementScreen(),
                Center(child: Text('Contenido de la pantalla de School')),
              ],
            ),
          ),
        ),
      ]),
      bottomNavigationBar: FooterNavigator(
        primaryColor: primaryColor,
        currentIndex: _currentIndex,
        onItemTapped: (index) {
          setState(() {
            _currentIndex = index;
          });
          if (index == 1) {
            final typeMovement =
                Provider.of<TypeMovementProvider>(context, listen: false);
            typeMovement.getAllTypeMovement();
            final category =
                Provider.of<CategoryProvider>(context, listen: false);
            category.getAllCategory();
          }
        },
      ),
    );
  }
}
