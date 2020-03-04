import 'dart:io';

import 'package:fl_lamp/libraries/constants.dart';
import 'package:fl_lamp/libraries/lamp_state.dart';

class UdpManager {
  InternetAddress _localIp;
  InternetAddress _remoteIp;
  int _localPort;
  int _remotePort;
  RawDatagramSocket _socket;

  CallBackResponseFunc _callBackResponseFunc;

  UdpManager._internal();

  static final UdpManager _udpManager = UdpManager._internal();

  factory UdpManager() {
    return _udpManager;
  }

  init(String localIp, int localPort) {
    _localIp = new InternetAddress(localIp);
    _localPort = localPort;
    try {
      RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
          .then((RawDatagramSocket socket) {
        _socket = socket;
        listen();
      });
    } catch (exception) {
      print(exception.toString());
    }
  }

  void addCallBack(CallBackResponseFunc callBackResponseFunc) {
    _callBackResponseFunc = callBackResponseFunc;
  }

  void send(String message) {
    print("UDP Socket ready to send to group "
        "${_remoteIp.address}:$DEFAULT_LAMP_PORT");
    print(message);
    _socket.send(message.codeUnits, _remoteIp, DEFAULT_LAMP_PORT);
  }

  void listen() {
    print('UDP Echo ready to receive');
    print('${_socket.address.address}:${_socket.port}');
    _socket.listen((RawSocketEvent e) {
      Datagram datagram = _socket.receive();
      if (datagram == null) return;
      String message = new String.fromCharCodes(datagram.data);
      print(
          'Datagram from ${datagram.address.address}:${datagram.port}: ${message.trim()}');
      parseResponse(message);
      _callBackResponseFunc();
    });
  }

  void setIpAddress(String ip) {
    _remoteIp = new InternetAddress(ip);
  }

  void setPort(String port) {
    _remotePort = int.parse(port);
  }

  void sendSliderCommand(COMMANDS command, int value) {
    final qCom =
        command.toString().substring(command.toString().indexOf('.') + 1);
    var query = value == null ? qCom : '$qCom $value';
    send(query);
  }

  void parseResponse(String response) {
    var splitedC = response.split(" ");
    print(splitedC[0]);

    if (splitedC[0] == "CURR") {
      LampState.setLampState(splitedC);
    }
  }
}

typedef CallBackResponseFunc = void Function();
