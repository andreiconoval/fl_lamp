import 'package:fl_lamp/udp/udp_manager.dart';

class LampManager {

  LampManager._internal();

  static final LampManager _lampManager = LampManager._internal();

  factory LampManager() {
    return _lampManager;
  }

  init() {
  }

  void getLampState() {
    UdpManager.send("GET");
  }
}
