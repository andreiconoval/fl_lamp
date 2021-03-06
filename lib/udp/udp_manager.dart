import 'dart:io';
import 'package:wifi/wifi.dart';
import 'package:fl_lamp/libraries/constants.dart';
import 'package:fl_lamp/libraries/lamp_state.dart';

class UdpManager {
  static InternetAddress _localIp;
  static InternetAddress remoteIp;
  static int _localPort;
  static int _remotePort;
  static RawDatagramSocket _socket;
  static CallBackResponseFunc _callBackResponseFunc;
  static UpdateAppState _updateAppState;
  static List<String> addressList = [];

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
    } on SocketException catch (_) {
      print('not connected');
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

  static void addUpdateAppState(UpdateAppState updateAppState) {
    _updateAppState = updateAppState;
  }

  static void send(String message) {
    if (remoteIp == null) return;
    print("UDP Socket ready to send to group "
        "${remoteIp.address}:$DEFAULT_LAMP_PORT");
    print(message);
    _socket.send(message.codeUnits, remoteIp, DEFAULT_LAMP_PORT);
    _updateAppState();
    _callBackResponseFunc();
  }

  static void listen() {
    try {
      print('UDP Echo ready to receive');
      print('${_socket.address.address}:${_socket.port}');
      _socket.listen((RawSocketEvent e) {
        Datagram datagram = _socket.receive();
        if (datagram == null) {
          LampState.isConnected = false;
          _callBackResponseFunc();
          _updateAppState();
          return;
        }
        LampState.isConnected = true;
        String message = new String.fromCharCodes(datagram.data);
        print(
            'Datagram from ${datagram.address.address}:${datagram.port}: ${message.trim()}');
        _parseResponse(message);
        _callBackResponseFunc();
        _updateAppState();
      });
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  static void setIpAddress(String ip) {
    remoteIp = new InternetAddress(ip);
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

    if (splitedC[0] == "ALMS") {
      LampState.setAlarmState(splitedC);
    }

    if (splitedC[0] == "OK") {
      LampState.isConnected = true;
    }
  }

  static Future<void> discover() async {
    try {
      final String subnet =
          _localIp.address.substring(0, _localIp.address.lastIndexOf('.'));
      for (int i = 1; i < 256; ++i) {
        final host = '$subnet.$i';
        final iAddr = new InternetAddress(host);

        await _ping(iAddr, DEFAULT_LAMP_PORT, "DEB");
      }
    } on SocketException catch (_) {
      print('not connected');
    }
  }

  static Future<void> _ping(InternetAddress host, int port, String text) {
    RawDatagramSocket.bind(InternetAddress.anyIPv4, 0)
        .then((RawDatagramSocket socket) {
      socket.listen((RawSocketEvent e) {
        Datagram datagram = socket.receive();
        if (datagram == null) return;
        addressList.add(datagram.address.address);
        _callBackResponseFunc();
      });
      try {
        socket.send(text.codeUnits, host, DEFAULT_LAMP_PORT);
      } on SocketException catch (_) {
        print('not connected');
        return;
      }
    });
  }
}

typedef CallBackResponseFunc = void Function();
typedef UpdateAppState = void Function();
