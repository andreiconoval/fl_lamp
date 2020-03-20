import 'package:fl_lamp/components/alarm.dart';
import 'package:fl_lamp/udp/udp_manager.dart';
import 'package:fl_lamp/widgets/bottom_nav_bar.dart';
import 'package:fl_lamp/widgets/top_choice.dart';
import 'package:flutter/material.dart';
import 'package:fl_lamp/libraries/lamp_state.dart';

import 'components/connect.dart';
import 'components/effects.dart';
import 'libraries/constants.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    UdpManager.init();
    return MaterialApp(
      title: 'Lamp app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'LAMP APP'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Choice _selectedChoice = choices[0]; // The app's "state".

  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;

      if (index == 2) UdpManager.send(commandToString(COMMANDS.ALM_GET));
    });
  }

  void changeState(){
    setState(() {
    });
  }

  void _select(Choice choice) {
    // Causes the app to rebuild with the new _selectedChoice.
    setState(() {
      _selectedChoice = choice;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    new Connection(),
    new Effects(),
    new Alarm(),
  ];
  @override
  Widget build(BuildContext context) {
    UdpManager.addUpdateAppState(changeState);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 9, 139, 198),
          title: Text(widget.title),
          leading: Icon(
            Icons.cast_connected,
            color: LampState.isConnected ? Color.fromARGB(255, 232, 247, 247) : Colors.red,
            size: 34.0,
          ),
          centerTitle: true,
          actions: <Widget>[
            // overflow menu
            PopupMenuButton<Choice>(
              onSelected: _select,
              itemBuilder: (BuildContext context) {
                return choices.map((Choice choice) {
                  return PopupMenuItem<Choice>(
                    value: choice,
                    child: Text(choice.title),
                  );
                }).toList();
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        body: _widgetOptions.elementAt(_selectedIndex),
        bottomNavigationBar: new BottomNavBar(
            onItemTapped: _onItemTapped, selectedIndex: _selectedIndex));
  }
}
