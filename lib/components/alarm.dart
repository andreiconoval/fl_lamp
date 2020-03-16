import 'package:fl_lamp/udp/udp_manager.dart';
import 'package:fl_lamp/widgets/day_alarm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Alarm extends StatefulWidget {
  @override
  _Alarm createState() => new _Alarm();
}

class _Alarm extends State<Alarm> {
  
  void changeState() {
    setState(() {});
  }

  var days = [
    DayAlarm(id: 1, name: 'Monday', isOn: false, minutes: 0),
    DayAlarm(id: 2, name: 'Tuesday', isOn: false, minutes: 0),
    DayAlarm(id: 3, name: 'Wednesday', isOn: false, minutes: 0),
    DayAlarm(id: 4, name: 'Thursday', isOn: false, minutes: 0),
    DayAlarm(id: 5, name: 'Friday', isOn: false, minutes: 0),
    DayAlarm(id: 6, name: 'Saturday', isOn: false, minutes: 0),
    DayAlarm(id: 7, name: 'Sunday', isOn: false, minutes: 0),
  ];


  @override
  Widget build(BuildContext context) {

    UdpManager.addCallBack(changeState);
    var dayAlarmWIdgets = <Widget>[];
    days.forEach((d) {
      var dayRowWidget = d.createRow(context, changeState);
      dayAlarmWIdgets.add(dayRowWidget);
      return dayAlarmWIdgets.add(new Divider(
        color: Colors.blueGrey,
        indent: 40,
        endIndent: 40,
      ));
    });

    UdpManager.addCallBack(changeState);
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(height: 20),
        Text(
          'Set Alarm',
          style: TextStyle(fontSize: 24),
        ),
        SizedBox(height: 10),
        ...dayAlarmWIdgets,
        CupertinoButton(child: Text("press"), onPressed: () => {})
      ],
    );
  }
}

