import 'package:app_settings/app_settings.dart';
import 'package:existing_ui/Screens/LocationScreen.dart';
import 'package:existing_ui/Screens/WifiPage.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';


class BluetoothScreen extends StatefulWidget {
  const BluetoothScreen({Key? key}) : super(key: key);

  @override
  State<BluetoothScreen> createState() => _BluetoothScreenState();
}

class _BluetoothScreenState extends State<BluetoothScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  Future<bool> _checkDeviceBluetoothIsOn() async {
    return await flutterBlue.isOn;
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<BluetoothState>(
          stream: FlutterBlue.instance.state,
          initialData: BluetoothState.unknown,
          builder: (c, snapshot) {
            final state = snapshot.data;
            if (state == BluetoothState.on) {
              Fluttertoast.showToast(
                msg: 'Bluetooth is On',
                backgroundColor: Colors.grey,
              );
              return WifiPage();
            }
            print(state);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                body: SingleChildScrollView(
                  child: SafeArea(
                    child: Center(
                      child: Container(
                        child: Column(
                          children:[
                                SizedBox(height: 109.h), Container(
                                  height: 150,
                                  padding: EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width-60,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      )
                                  ),
                                  child: Column(
                                    children: [
                                      Text("Permission", style: TextStyle(
                                          fontWeight: FontWeight.bold
                                      ),),
                                      SizedBox(
                                        height: 20.h,
                                      ),
                                      Expanded(child: Text("Allow Gauge RO to open Your Bluetooth. For a better experince turn on Bluetooth")),
                                      InkWell(onTap: (){
                                        AppSettings.openBluetoothSettings();
                                      },child: const Text("Allow",style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20
                                      ),),)
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 109.h,
                                ),
                                Container(
                                  height: 150,
                                  padding: EdgeInsets.all(10),
                                  width: MediaQuery.of(context).size.width-60,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 2,
                                      )
                                  ),
                                    child: Expanded(
                                      child: Text(
                                        "It looks like you have turned off permission required for this app. You can click allow button for permission"
                                      ),
                                    ),
                                  ),
                      ]
                      ),
                  ),
                    ),
                ),
              ),),
            );
            // return BluetoothOffScreen(state: state);
          }),
    );
  }
}
