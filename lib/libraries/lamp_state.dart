library globals.lamp_state;

import 'package:fl_lamp/widgets/day_alarm.dart';

class LampState {
  static String ip = "";
  static bool isConnected = false;
  static bool isTurnedOn = false;
  static int brightness = 0;
  static int speed = 0;
  static int scale = 0;
  static int currentMode = 0;
  static bool onFlag = false;
  static bool espMode = false;
  static bool useNtp = false;
  static bool buttonEnabled = true;
  static bool timerEnabled = false;
  static DateTime dateTime = DateTime.now();

  static List<DayAlarm> daysAlarm = [
    DayAlarm(id: 1, name: 'Monday', isOn: false, minutes: 0),
    DayAlarm(id: 2, name: 'Tuesday', isOn: false, minutes: 0),
    DayAlarm(id: 3, name: 'Wednesday', isOn: false, minutes: 0),
    DayAlarm(id: 4, name: 'Thursday', isOn: false, minutes: 0),
    DayAlarm(id: 5, name: 'Friday', isOn: false, minutes: 0),
    DayAlarm(id: 6, name: 'Saturday', isOn: false, minutes: 0),
    DayAlarm(id: 7, name: 'Sunday', isOn: false, minutes: 0),
  ];

  static int wakeUpminutes = 0;

  static String rawCURR;
  static String rawALM;

  static void setLampState(List<String> stateList) {
    isConnected = true;
    currentMode = int.parse(stateList[1]);
    brightness = int.parse(stateList[2]);
    speed = int.parse(stateList[3]);
    scale = int.parse(stateList[4]);
    onFlag = stateList[5] == '1' ? true : false;
    espMode = stateList[6] == '1' ? true : false;
    timerEnabled = stateList[7] == '1' ? true : false;
    buttonEnabled = stateList[8] == '1' ? true : false;
    dateTime = DateTime.parse(stateList[10]);
  }

  static void setAlarmState(List<String> alarmState) {
    isConnected = true;
    daysAlarm[1].isOn = alarmState[1] == '1' ? true : false;
    daysAlarm[2].isOn = alarmState[2] == '1' ? true : false;
    daysAlarm[3].isOn = alarmState[3] == '1' ? true : false;
    daysAlarm[4].isOn = alarmState[4] == '1' ? true : false;
    daysAlarm[5].isOn = alarmState[5] == '1' ? true : false;
    daysAlarm[6].isOn = alarmState[6] == '1' ? true : false;
    daysAlarm[7].isOn = alarmState[7] == '1' ? true : false;

    daysAlarm[1].minutes = int.parse(alarmState[8]);
    daysAlarm[2].minutes = int.parse(alarmState[9]);
    daysAlarm[3].minutes = int.parse(alarmState[10]);
    daysAlarm[4].minutes = int.parse(alarmState[11]);
    daysAlarm[5].minutes = int.parse(alarmState[12]);
    daysAlarm[6].minutes = int.parse(alarmState[13]);
    daysAlarm[7].minutes = int.parse(alarmState[14]);

    wakeUpminutes = int.parse(alarmState[15]);
  }
}
