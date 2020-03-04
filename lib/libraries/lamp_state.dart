library globals.lamp_state;

bool isConnected = false;
bool isTurnedOn = false;
int brightness = 0;
int speed = 0;
int scale = 0;
int currentMode = 0;
bool onFlag = false;
bool espMode = false;
bool useNtp = false;
bool buttonEnabled = true;
DateTime dateTime;

class LampState {
  bool isConnected = false;
  bool isTurnedOn = false;
  int brightness = 0;
  int speed = 0;
  int scale = 0;
  int currentMode = 0;
  bool onFlag = false;
  bool espMode = false;
  bool useNtp = false;
  bool buttonEnabled = true;
  DateTime dateTime;
  
  void setLampState(List<String> stateList) {
    isConnected = true;
    currentMode = int.parse(stateList[1]);
    brightness = int.parse(stateList[2]);
    speed = int.parse(stateList[3]);
    scale = int.parse(stateList[4]);
  }
}
