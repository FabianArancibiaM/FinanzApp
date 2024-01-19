import 'package:flutter/material.dart';

class FooterNavigator extends StatelessWidget {
  const FooterNavigator({
    Key? key,
    required this.primaryColor,
    required this.currentIndex,
    required this.onItemTapped,
  }) : super(key: key);

  final Color primaryColor;
  final int currentIndex;
  final ValueChanged<int> onItemTapped;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(
            Icons.addchart_outlined,
            color: primaryColor,
          ),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business, color: primaryColor),
          label: 'Business',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.school, color: primaryColor),
          label: 'School',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.amber[800],
      onTap: onItemTapped,
    );
  }
}
