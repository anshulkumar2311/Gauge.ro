import 'package:flutter/material.dart';

class NewUser extends StatelessWidget {
  const NewUser({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Container(
            padding: EdgeInsets.all(15),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                  ),
                  Text("Registration Page", style: TextStyle(
                    color: Colors.black,
                    fontSize: 30,
                  ))
                ],
              ),
            ),
        ),
      ),
    );
  }
}
