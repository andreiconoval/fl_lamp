library globals.lamp_state;

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
}
