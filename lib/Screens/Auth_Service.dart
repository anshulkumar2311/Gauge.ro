import 'package:existing_ui/Screens/LocationScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthClass{
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  final storage = new FlutterSecureStorage();
  FirebaseAuth auth = FirebaseAuth.instance;
  Future<void> googleSignIn(BuildContext context) async{
    try{
      GoogleSignInAccount? googleSignInAccount =await _googleSignIn.signIn();
      if(googleSignInAccount!=null){
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        try{
          UserCredential userCredential = await auth.signInWithCredential(credential);
          storageToken(userCredential);
          Navigator.push(context, MaterialPageRoute(builder: (builder) => LocationScreen()));
        }
        catch(e){
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      }
      else{
        final snackbar = SnackBar(content: Text("Not able to sign in"));
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    }
    catch(e){
      print(e);
      final snackbar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackbar);
    }
  }

  Future<void> logout() async{
    try{
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: "token");
    }
    catch(e){
      print(e);
    }
  }

  Future<void> storageToken(UserCredential userCredential) async{
    await storage.write(key: "token", value: userCredential.credential?.token.toString());
    await storage.write(key: "userCredential", value: userCredential.toString());
  }
  Future<String?> getTocken() async{
    return await storage.read(key: "token");
  }

  Future<void>? verifyPhoneNumber(String phoneNumber, BuildContext context, Function setData ) async{
    PhoneVerificationCompleted verificationCompleted = (PhoneAuthCredential phoneAuthCredential) async{
      Fluttertoast.showToast(
        msg: "Verification Complete",
        backgroundColor: Colors.grey,
      );
    };
    PhoneVerificationFailed verificationFailed = (FirebaseAuthException exception){

      Fluttertoast.showToast(
        msg: exception.toString(),
        backgroundColor: Colors.grey,
      );;
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationID) {

          Fluttertoast.showToast(
            msg: "Time Out",
            backgroundColor: Colors.grey,
          );
    };

    try{
      await auth.verifyPhoneNumber(verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          phoneNumber: phoneNumber,
          codeSent: (String? verificationId,int? resendToken){

            Fluttertoast.showToast(
              msg: "Verification Code Send To Phone Number",
              backgroundColor: Colors.grey,
            );
            setData(verificationId);
          },
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
    }
    catch(e){
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.grey,
      );
    }
  }

  Future<void>? SignInWithPhoneNumber(String verificationId,String smsCode, BuildContext context) async{
    try{
      AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId,
          smsCode: smsCode);
      UserCredential userCredential = await auth.signInWithCredential(credential);
      storageToken(userCredential);
      Navigator.push(context, MaterialPageRoute(builder: (builder)=> LocationScreen()),);

      Fluttertoast.showToast(
        msg: "Logged In",
        backgroundColor: Colors.grey,
      );
    }
    catch(e){
      Fluttertoast.showToast(
        msg: e.toString(),
        backgroundColor: Colors.grey,
      );
      print("Error1");
    }
  }

}