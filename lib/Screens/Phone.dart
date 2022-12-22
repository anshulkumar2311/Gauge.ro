import 'package:existing_ui/Screens/NewUser.dart';
import 'package:existing_ui/Screens/OTPScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import '../shared/res/colors.dart';

class PhoneLogin extends StatefulWidget {
  const PhoneLogin({Key? key}) : super(key: key);

  @override
  State<PhoneLogin> createState() => _PhoneLoginState();
}

class _PhoneLoginState extends State<PhoneLogin> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
           child:  SingleChildScrollView(
             reverse: true,
             child: Container(
                color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(height: 109.h),
                      Image.asset("assets/images/logo.png",
                          color: SmartyColors.primary, width: 200.w),
                      SizedBox(height: 150.h),
                      InkWell(
                        onTap: (){},
                        child: Container(
                          width: MediaQuery.of(context).size.width-60,
                          padding: EdgeInsets.only(left: 50),
                          height: 60.h,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 2,
                              ),
                          ),
                          child: Row(
                            children: [
                             Text("LogIn with Whatsapp",style: TextStyle(
                               fontSize: 20,
                               color: Colors.black
                             ),),
                              SizedBox(width: 20,),
                              Icon(Icons.whatsapp,color: Colors.green,size: 30,)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 32.h,),
                      Text("OR",style: TextStyle(
                        fontSize: 30,
                      ),),
                      SizedBox(height: 32.h),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>PhoneAuthPage()));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width-60,
                          padding: EdgeInsets.only(left: 50),
                          height: 60.h,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.black,
                              width: 2,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text("LogIn with Phone",style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.black
                              ),),
                              SizedBox(width: 30,),
                              Icon(Icons.phone,color: Colors.black,size: 30,)
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 14.h),
                      InkWell(
                        onTap: (){
                          Navigator.push(context, MaterialPageRoute(builder: (builder)=>NewUser() ));
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 20),
                          child: Text("New User?",style: TextStyle(
                            fontWeight: FontWeight.w700,
                          ),)
                        ),
                      ),
                      SizedBox(height: 28.h),
                      // ElevatedButton(onPressed: (){
                      //  if(_formkey.currentState!.validate()){
                      //
                      //    Navigator.push(context, MaterialPageRoute(builder: (builder)=>const PhoneAuthPage() ));
                      //  }
                      // }, child: Text("Next")),
                    ],
                  ),
                ),
           ),
            ),
      ),
    );
  }


  Widget textItem(String labletxt, TextEditingController controller) {
    return Container(
      padding: EdgeInsets.only(left: 20,right: 20),
      height: 55,
      child: TextFormField(
        controller: controller,
        style: TextStyle(
          fontSize: 17,
          color: Colors.white,
        ),
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: labletxt,
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14,horizontal: 15),
            child: Text("+91", style: TextStyle(
                color: Colors.black26,fontSize: 18,fontWeight: FontWeight.bold
            ),),
          ),
        ),),
    );
  }
}