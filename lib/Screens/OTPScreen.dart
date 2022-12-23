import 'dart:async';
import 'package:existing_ui/Screens/Auth_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:permission_handler/permission_handler.dart';
import 'LocationScreen.dart';


class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);
  @override
  State<PhoneAuthPage> createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start=45;
  bool wait = false;
  String buttonName='Send';
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  String verificationIdFinal = '';
  String smsCode = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    height: 150.h,
                  ),
                  textField(),
                   SizedBox(
                    height: 30.h,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                            margin: EdgeInsets.symmetric(horizontal: 12.w),
                          ),
                        ),
                         Text("Enter 6 Digit OTP", style: TextStyle(
                            color: Colors.black,
                            fontSize:20.w,
                            fontWeight: FontWeight.bold
                        ),),
                        Expanded(
                          child: Container(
                            height: 1,
                            color: Colors.grey,
                            margin: EdgeInsets.symmetric(horizontal: 12.w),
                          ),
                        ),
                      ],
                    ),
                  ),
                   SizedBox(
                    height: 30.h,
                  ),
                  otpField(),
                   SizedBox(
                    height: 40.h,
                  ),
                  RichText(text: TextSpan(
                      children: [
                         TextSpan(text: "Send Otp again in ", style: TextStyle(
                            color: Colors.black,
                            fontSize: 18.w,
                            fontWeight: FontWeight.bold
                        )),
                        TextSpan(text: "00:$start", style:  TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.w,
                        )),
                         TextSpan(text: " sec", style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.w,
                        )),
                      ]
                  )),
                  SizedBox(height: 150.h,),
                  InkWell(
                    onTap: (){
                      authClass.SignInWithPhoneNumber(verificationIdFinal, smsCode, context);
                    },
                    child: Container(
                      height: 60.h,
                      width: MediaQuery.of(context).size.width - 80.w,
                      decoration: BoxDecoration(
                          gradient: const LinearGradient(colors: [
                            Color(0xff3120E0),
                            Color(0xff386fa4),
                            Color(0xff3120E0),
                          ]),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Text(
                          "Lets Go",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                        ),
                      ),
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

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField(){
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width-34,
      fieldWidth: 58.w,
      otpFieldStyle: OtpFieldStyle(
        backgroundColor: Colors.black26,
        borderColor: Colors.white54,
      ),
      style:  TextStyle(
        fontSize: 17.h,
        color: Colors.white,
      ),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onCompleted: (pin) {
        print("Completed: " + pin);
        setState(() {
          smsCode =pin;
        });
      },
    );
  }
  Widget textField(){
    return Container(
      width: MediaQuery.of(context).size.width-40,
      height: 60.h,
      decoration: BoxDecoration(
          color: Colors.black26,
          borderRadius: BorderRadius.circular(15.w)
      ),
      child: Form(
        key: _formkey,
        child: TextFormField(
          keyboardType: TextInputType.phone,
          controller: phoneController,
          validator: (value){
            if(value!.isEmpty){
              return "Enter Phone Number";
            }else if(!RegExp(r'^\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$').hasMatch(value)){
              return "Please Enter a Valid Phone Number";
            }
            return null;
          },
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Enter Your Phone Number",
              hintStyle: const TextStyle(
                color: Colors.white54,fontSize: 16,fontWeight: FontWeight.bold,
              ),
              contentPadding:  EdgeInsets.symmetric(vertical: 19.w,horizontal: 8.w),
              prefixIcon: const Padding(
                padding: EdgeInsets.symmetric(vertical: 14,horizontal: 15),
                child: Text("+91", style: TextStyle(
                    color: Colors.blue,fontSize: 18,fontWeight: FontWeight.bold
                ),),
              ),
              suffixIcon: InkWell(
                onTap:wait?null: () async{
                  var SMS = await Permission.sms.status;
                  if(!SMS.isGranted){
                    await Permission.sms.request();
                  }
                  if(SMS.isGranted){
                  Fluttertoast.showToast(
                    msg: "SMS Permission Given",
                    backgroundColor: Colors.grey,
                  );
                  if(_formkey.currentState!.validate()) {
                    startTimer();
                    setState(() {
                      start = 45;
                      wait = true;
                      buttonName = "Resend";
                    });
                  }
                  else{
                    Fluttertoast.showToast(
                      msg: "Please Allow for SMS Permission",
                      backgroundColor: Colors.grey,
                    );
                  }
                  await authClass.verifyPhoneNumber("+91 ${phoneController.text}", context,setData);
                }
                  else{
                  Fluttertoast.showToast(
                  msg: "Please Allow for SMS Permission",
                  backgroundColor: Colors.grey,
                  );
                  await Permission.sms.request();
                  }
                  },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20,horizontal: 15),
                  child: Text(buttonName, style: TextStyle(
                    color:wait?Colors.white : Colors.blue,fontSize: 17,fontWeight: FontWeight.bold,
                  ),),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  width: 1.5,
                  color: Colors.black26,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    width: 1,
                    color: Colors.grey,
                  )))
          ),
        ),
      );
  }
  void setData(verificationId){
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}

