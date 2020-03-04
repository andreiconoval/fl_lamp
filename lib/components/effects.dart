import 'package:fl_lamp/libraries/constants.dart';
import 'package:fl_lamp/libraries/lamp_state.dart';
import 'package:fl_lamp/udp/udp_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Effects extends StatefulWidget {
  Effects({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _Effects createState() => _Effects();
}

class _Effects extends State<Effects> {
  static UdpManager _udpManager = new UdpManager();

  String text = EFFECTS[LampState.currentMode];

  void parseRecivedState() {
    setState(() {
    });
  }

  @override
  Widget build(BuildContext context) {
    _udpManager.addCallBack(parseRecivedState);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: Center(child: Text("Select Effect")),
          ),
          Expanded(
            flex: 6,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SizedBox(),
                ),
                Expanded(
                  flex: 7,
                  child: ListView.builder(
                    itemCount: EFFECTS.length,
                    itemBuilder: (context, position) {
                      return GestureDetector(
                        onTap: () => {
                          setState(() {
                            LampState.currentMode = position;
                            text = EFFECTS[LampState.currentMode];
                            _udpManager.sendSliderCommand(
                                COMMANDS.EFF, LampState.currentMode);
                            LampState.currentMode = LampState.currentMode;
                          })
                        },
                        child: Card(
                          color: LampState.currentMode == position
                              ? Colors.blueAccent
                              : Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Center(
                              child: Text(
                                EFFECTS[position],
                                style: TextStyle(fontSize: 16.0),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        flex: 7,
                        child: RotatedBox(
                          quarterTurns: 3,
                          child: Slider(
                            value: LampState.scale.toDouble(),
                            onChangeEnd: (double newValue) {
                              setState(() {
                                LampState.scale = newValue.round();
                                _udpManager.sendSliderCommand(
                                    COMMANDS.SCA, LampState.scale);
                              });
                            },
                            onChanged: (double newValue) {},
                            min: 0,
                            max: 256,
                            divisions: 256,
                            activeColor: Colors.blue,
                          ),
                        ),
                      ),
                      Expanded(child: Text("Scale"))
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Expanded(child: Text("Speed"), flex: 1),
                Expanded(
                    flex: 9,
                    child: Slider(
                        min: 0,
                        max: 256,
                        divisions: 256,
                        value: LampState.speed.toDouble(),
                        activeColor: Color(0xffff520d),
                        inactiveColor: Colors.blueGrey,
                        onChanged: (newSpeed) {
                          setState(() {
                            LampState.speed = newSpeed.round();
                            _udpManager.sendSliderCommand(
                                COMMANDS.SPD, LampState.speed);
                          });
                        })),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Row(
              children: <Widget>[
                Expanded(child: Text("Bri"), flex: 1),
                Expanded(
                    flex: 9,
                    child: Slider(
                        min: 0,
                        max: 256,
                        divisions: 256,
                        value: LampState.brightness.toDouble(),
                        activeColor: Colors.yellow,
                        inactiveColor: Colors.blueGrey,
                        onChanged: (newBrightness) {
                          setState(() {
                            LampState.brightness = newBrightness.round();
                            _udpManager.sendSliderCommand(
                                COMMANDS.BRI, LampState.brightness);
                          });
                        })),
              ],
            ),
          ),
          Expanded(child: SizedBox(), flex: 2)
        ],
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            if (LampState.isTurnedOn) {
              _udpManager.sendSliderCommand(COMMANDS.P_OFF, null);
              LampState.isTurnedOn = false;
            } else {
              _udpManager.sendSliderCommand(COMMANDS.P_ON, null);
              LampState.isTurnedOn = true;
            }
          });
        },
        child: Icon(Icons.power_settings_new),
        backgroundColor: LampState.isTurnedOn ? Colors.green : Colors.red,
      ),
    );
  }
}
