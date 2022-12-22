import 'package:existing_ui/Screens/LocationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WifiScreen extends StatefulWidget {
  const WifiScreen({Key? key}) : super(key: key);

  @override
  State<WifiScreen> createState() => _WifiScreenState();
}

class _WifiScreenState extends State<WifiScreen> {
  bool value=false;
  bool value2=false;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                SizedBox(height: 109.h),
                Text("Make Sure your device is on",style: TextStyle(
                  fontSize: 20
                ),),
                Divider(
                  color: Colors.black,
                  height: 20,
                  thickness: 2,
                  indent: 70,
                  endIndent: 70,
                ),
                SizedBox(
                  height: 15,
                ),
                Text("Make Sure you Home Wifi is Avaiable",style: TextStyle(
                  fontSize: 20
                ),),
                Divider(
                  color: Colors.black,
                  height: 20,
                  thickness: 2,
                  indent: 30,
                  endIndent: 30,
                ),
                SizedBox(
                  height: 50.h,
                ),
                Container(
                  width: MediaQuery.of(context).size.width-60,
                  padding: const EdgeInsets.all(30),
                  decoration: BoxDecoration(
                   border: Border.all(
                     color: Colors.black,
                     width: 2,
                   )
                  ),
                  child: Text("Sit back and relax our maintenance team will help you get connected to the device"),
                ),
                SizedBox(
                  height: 200.h,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Checkbox(
                          value: this.value,
                          onChanged: (bool? value) {
                            setState(() {
                              this.value = value!;
                            });
                          },
                        ),//SizedBox
                        Expanded(
                          child: Text(
                            'By Clicking this you allow us to use this data to help personalize your experience better. None of this data will we shared to any third party',
                            style: TextStyle(fontSize: 17.0),
                          ),
                        ), //Text
                        SizedBox(width: 10), //SizedBox
                        /** Checkbox Widget **/
                      ],
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Checkbox(
                          value: this.value2,
                          onChanged: (bool? value2) {
                            setState(() {
                              this.value2 = value2!;
                            });
                          },
                        ),//SizedBox
                        Text(
                          "I agree to all terms and conditions.",
                          style: TextStyle(fontSize: 17.0),
                        ), //Text
                        SizedBox(width: 10), //SizedBox
                        /** Checkbox Widget **/
                      ],
                    ),
                    SizedBox(height: 20.h,),
                    ElevatedButton(onPressed: (){
                      if(value && value2){
                        Navigator.push(context, MaterialPageRoute(builder: (builder)=>LocationScreen()));
                      }
                      else{
                        Fluttertoast.showToast(
                          msg: 'Select above Options',
                          backgroundColor: Colors.red,
                        );
                      }
                    }, child: Text(
                      "Next"
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
