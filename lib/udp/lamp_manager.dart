import 'package:fl_lamp/udp/udp_manager.dart';

class LampManager {
  UdpManager _udpManager;

  LampManager._internal();

  static final LampManager _lampManager = LampManager._internal();

  factory LampManager() {
    return _lampManager;
  }

  init() {
    _udpManager = UdpManager();
  }

  void getLampState() {
    _udpManager.send("GET");
  }
}
