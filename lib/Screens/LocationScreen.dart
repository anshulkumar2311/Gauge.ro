import 'package:existing_ui/Screens/BluetoothPermission.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  void getLocation() async{
    LocationPermission permission;
    permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    print(position);
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
        Fluttertoast.showToast(
          msg: 'Provide Access to Location',
          backgroundColor: Colors.grey,
        );
    }
    else if (permission == LocationPermission.deniedForever) {
    Fluttertoast.showToast(
    msg: 'Location permissions are permanently denied, we cannot request permissions.',
    backgroundColor: Colors.grey,
    );
    }
    else{
      Navigator.push(context, MaterialPageRoute(builder: (builder)=>BluetoothPermission()));
    }
  }
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
                              Expanded(child: Text("Allow Gauge RO to view Your Location. For a better experince turn on device location")),
                              InkWell(onTap: (){
                                getLocation();
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
