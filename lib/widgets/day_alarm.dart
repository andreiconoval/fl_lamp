import 'package:fl_lamp/libraries/constants.dart';
import 'package:fl_lamp/udp/udp_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DayAlarm {
  int id;
  String name;
  int minutes;
  bool isOn = false;
  TimeOfDay get selectedTime => TimeOfDay(hour: minutes ~/ 60, minute: minutes % 60);
  set selectedTime(TimeOfDay val) => minutes = val.hour*60 + val.minute;

  DayAlarm({
    this.id,
    this.name,
    this.minutes,
    this.isOn,
  });

  void setTime() {
    String message = commandToString(COMMANDS.ALM_SET);
    message += id.toString();
    message += " ";
    message += minutes.toString();
    UdpManager.send(message);
  }

  void setAlarm() {
    String message = commandToString(COMMANDS.ALM_SET);
    message += id.toString();
    message += " ";
    message += isOn ? "ON" : "OFF";
    UdpManager.send(message);
  }

  Future<Null> selectDate(BuildContext context, Function changeState) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      selectedTime = picked;
      this.minutes = picked.hour * 60;
      this.minutes += picked.minute;
      changeState();
      setTime();
    }
  }

  Row createRow(BuildContext context, Function changeState) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
            child: Container(
              height: 35,
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
            flex: 5),
        new Expanded(
            child: GestureDetector(
                onTap: () => selectDate(context, changeState),
                child: Container(
                    height: 35,
                    child: Center(
                      child: Text(
                        selectedTime.format(context),
                        style: TextStyle(fontSize: 17),
                      ),
                    ))),
            flex: 3),
        new Expanded(
            child: Container(
                height: 30,
                alignment: AlignmentDirectional.topStart,
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Switch(
                      activeColor: Colors.blueAccent,
                      value: isOn,
                      onChanged: (stat) {
                        isOn = stat;
                        setAlarm();
                      },
                    )
                  ],
                )),
            flex: 2),
        new Expanded(child: const SizedBox(width: 20), flex: 1),
      ],
    );
  }
}
