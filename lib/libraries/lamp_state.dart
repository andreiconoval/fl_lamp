library globals.lamp_state;

 class LampState {
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
  static DateTime dateTime;
  
  static void setLampState(List<String> stateList) {
    isConnected = true;
    currentMode = int.parse(stateList[1]);
    brightness = int.parse(stateList[2]);
    speed = int.parse(stateList[3]);
    scale = int.parse(stateList[4]);
  }
}
