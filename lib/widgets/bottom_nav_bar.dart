import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({this.onItemTapped, this.selectedIndex});

  final OnItemTapped onItemTapped;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.wifi),
          title: Text('Connect'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.ac_unit),
          title: Text('Efects'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.alarm),
          title: Text('Alarm'),
        ),
      ],
      currentIndex: selectedIndex,
      selectedItemColor: Colors.amber[800],
      onTap: onItemTapped,
    );
  }
}

typedef OnItemTapped = void Function(int index);
