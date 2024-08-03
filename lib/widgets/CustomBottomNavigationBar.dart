// custom_bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:pet_adoption/account.dart';
import 'package:pet_adoption/product_add_page.dart';
import 'package:pet_adoption/screens/home.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<IconData> icons = [
      Icons.home,
      Icons.search,
      Icons.add,
      Icons.notifications,
      Icons.person_outline,
    ];

    return BottomNavigationBar(
      currentIndex: 2,
      items: icons.map((icon) => item(icon)).toList(),
      showSelectedLabels: false,
      showUnselectedLabels: false,
      backgroundColor: Colors.white,
      selectedItemColor: Colorz.accountPurple,
      unselectedItemColor: Colors.grey,
      onTap: (index) {
        if (index == 0) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );
        } else if (index == 2) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ProductAdd()),
          );
        } else if (index == 4) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccountPage()),
          );
        }
      },
    );
  }

  BottomNavigationBarItem item(IconData icon) {
    return BottomNavigationBarItem(
      icon: icon == Icons.add ? addButton() : Icon(icon),
      label: "",
    );
  }

  Widget addButton() {
    return CircleAvatar(
      child: Icon(Icons.add, color: Colors.white),
      backgroundColor: Colorz.accountPurple,
    );
  }
}
