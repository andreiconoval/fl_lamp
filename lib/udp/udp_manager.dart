import 'dart:io';
import 'package:wifi/wifi.dart';
import 'package:fl_lamp/libraries/constants.dart';
import 'package:fl_lamp/libraries/lamp_state.dart';

class UdpManager {
  static InternetAddress _localIp;
  static InternetAddress _remoteIp;
  static int _localPort;
  static int _remotePort;
  static RawDatagramSocket _socket;
  static CallBackResponseFunc _callBackResponseFunc;
  static UpdateTopBarState _updateTopBarState;
  static List<String> addressList=[];

  UdpManager._internal();

  static final UdpManager _udpManager = UdpManager._internal();

  factory UdpManager() {
    return _udpManager;
  }

  static init() async {
    _localIp = new InternetAddress(await Wifi.ip);
    try {
      RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
          .then((RawDatagramSocket socket) {
        _socket = socket;
        listen();
      });
    } catch (exception) {
      print(exception.toString());
    }
    try {
      discover();
    } catch (exception) {
      print(exception.toString());
    }
  }

  static void addCallBack(CallBackResponseFunc callBackResponseFunc) {
    _callBackResponseFunc = callBackResponseFunc;
  }

  static void addUpdateTopBarState(UpdateTopBarState updateTopBarState){
    _updateTopBarState = updateTopBarState;
  }

  static void send(String message) {
    print("UDP Socket ready to send to group "
        "${_remoteIp.address}:$DEFAULT_LAMP_PORT");
    print(message);
    _socket.send(message.codeUnits, _remoteIp, DEFAULT_LAMP_PORT);
  }

  static void listen() {
    print('UDP Echo ready to receive');
    print('${_socket.address.address}:${_socket.port}');
    _socket.listen((RawSocketEvent e) {
      Datagram datagram = _socket.receive();
      if (datagram == null) return;
      String message = new String.fromCharCodes(datagram.data);
      print(
          'Datagram from ${datagram.address.address}:${datagram.port}: ${message.trim()}');
      _parseResponse(message);
      _callBackResponseFunc();
    });
  }

  static void setIpAddress(String ip) {
    _remoteIp = new InternetAddress(ip);
  }

  static void setPort(String port) {
    _remotePort = int.parse(port);
  }

  static void sendCommand(COMMANDS command, int value) {
    final qCom =
        command.toString().substring(command.toString().indexOf('.') + 1);
    var query = value == null ? qCom : '$qCom $value';
    send(query);
  }

  static void _parseResponse(String response) {
    var splitedC = response.split(" ");
    print(splitedC[0]);

    if (splitedC[0] == "CURR") {
      LampState.setLampState(splitedC);
    }
  }

  static Future<void> discover() async {
    final String subnet =
        _localIp.address.substring(0, _localIp.address.lastIndexOf('.'));
    for (int i = 1; i < 256; ++i) {
      final host = '$subnet.$i';
      final iAddr = new InternetAddress(host);
      await _ping(iAddr, DEFAULT_LAMP_PORT, "DEB");
    }
  }

  static Future<void> _ping(InternetAddress host, int port, String text) {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
        .then((RawDatagramSocket socket) {
      socket.listen((RawSocketEvent e) {
        Datagram datagram = socket.receive();
        if (datagram == null) return;
        String message = new String.fromCharCodes(datagram.data);
        addressList.add(
            'Datagram from ${datagram.address.address}:${datagram.port}: ${message.trim()}');
             _callBackResponseFunc();
      });
      socket.send(text.codeUnits, host, DEFAULT_LAMP_PORT);
      return;
    });
    
  }

    static Future<RawDatagramSocket> _ping2(InternetAddress host, int port, String text) {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
        .then((RawDatagramSocket socket) {
      return socket;
    });
  }
}

typedef CallBackResponseFunc = void Function();
typedef UpdateTopBarState = void Function();

