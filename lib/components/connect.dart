import 'package:fl_lamp/libraries/constants.dart';
import 'package:fl_lamp/libraries/lamp_state.dart';
import 'package:fl_lamp/udp/udp_manager.dart';
import 'package:flutter/material.dart';

class Connection extends StatefulWidget {
  @override
  _Connection createState() => new _Connection();
}

const String discovery_service = "_workstation._tcp";

class _Connection extends State<Connection> {
  final ipTextController = TextEditingController(text:UdpManager.remoteIp != null ? UdpManager.remoteIp.address: "");
  final portTextController = TextEditingController();

  void callBack() { 
    setState(() {
      
    });
  }

  Widget build(BuildContext context) {
    UdpManager.addCallBack(callBack);
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(width: 10),
            new Expanded(
              flex: 7,
              child: new TextField(
                controller: ipTextController,
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintText: 'Enter an IP Addres',
                  labelText: 'IP addres',
                  prefixIcon: const Icon(
                    Icons.link,
                    color: Colors.green,
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            new Expanded(
              flex: 3,
              child: new TextField(
                controller: portTextController,
                decoration: new InputDecoration(
                  border: new OutlineInputBorder(
                      borderSide: new BorderSide(color: Colors.teal)),
                  hintText: '8888',
                  labelText: 'Port',
                ),
              ),
            ),
            SizedBox(width: 10),
          ],
        ),
        SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Expanded(child: const SizedBox(width: 20), flex: 3),
            new Expanded(
                child: RaisedButton(
                  onPressed: () {
                    LampState.isConnected = false;
                    UdpManager.setIpAddress(ipTextController.text);
                    UdpManager.sendCommand(COMMANDS.GET, null);
                  },
                  color:LampState.isConnected ? Colors.greenAccent: Colors.yellowAccent,
                  colorBrightness: Brightness.light,
                  child: LampState.isConnected ? Text('Connected', style: TextStyle(fontSize: 20)):Text('Connect', style: TextStyle(fontSize: 20)),
                ),
                flex: 4),
            new Expanded(child: const SizedBox(width: 20), flex: 3),
          ],
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Expanded(child: const SizedBox(width: 20), flex: 3),
            new Expanded(
                child: Text( UdpManager.addressList.length > 0 ? UdpManager.addressList.toString(): "Nothing found"),
                flex: 4),
            new Expanded(child: const SizedBox(width: 20), flex: 3),
          ],
        )
      ],
    );
  }
}
