import 'package:existing_ui/Screens/Bluetooth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BluetoothPermission extends StatelessWidget {
  const BluetoothPermission({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: SafeArea(
            child: Center(
              child: Column(
                children: [
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
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>BluetoothScreen()));
                        },child: const Text("Allow",style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                            fontSize: 20
                        ),),)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
