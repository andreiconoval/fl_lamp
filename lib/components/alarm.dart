import 'package:fl_lamp/libraries/lamp_state.dart';
import 'package:fl_lamp/udp/udp_manager.dart';
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

  @override
  Widget build(BuildContext context) {
    UdpManager.addCallBack(changeState);
    var dayAlarmWIdgets = <Widget>[];
    LampState.daysAlarm.forEach((d) {
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
        Row(
          children: <Widget>[
            Expanded(
              child: SizedBox(),
              flex: 1,
            ),
            Expanded(
              child: Text(
                'Set Alarm',
                style: TextStyle(fontSize: 24),
              ),
              flex: 6,
            ),
            Expanded(
              child: Text(
                LampState.dateTime.hour.toString() +
                    ':' +
                    LampState.dateTime.minute.toString(),
                style: TextStyle(fontSize: 24),
              ),
              flex: 3,
            )
          ],
        ),
        SizedBox(height: 10),
        ...dayAlarmWIdgets,
      ],
    );
  }
}
