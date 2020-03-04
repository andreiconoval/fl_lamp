import 'package:fl_lamp/libraries/constants.dart';
import 'package:fl_lamp/udp/udp_manager.dart';
import 'package:flutter/material.dart';

class Connection extends StatelessWidget {
  final ipTextController = TextEditingController();
  final portTextController = TextEditingController();
  @override

  void callBack(){
     
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
                    UdpManager.setIpAddress(ipTextController.text);
                    UdpManager.sendCommand(COMMANDS.GET,null);
                  },
                  color: Colors.yellowAccent,
                  colorBrightness: Brightness.light,
                  child: const Text('Connect', style: TextStyle(fontSize: 20)),
                ),
                flex: 4),
            new Expanded(child: const SizedBox(width: 20), flex: 3),
          ],
        )
      ],
    );
  }
}
