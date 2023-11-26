import 'dart:async';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';
import 'homepage.dart';

class splash_screen extends StatefulWidget {
  const splash_screen({super.key});

  @override
  State<splash_screen> createState() => _splash_screenState();
}

class _splash_screenState extends State<splash_screen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Timer(Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>homepage()));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffADD8E6),
      body: Center(
        child: Stack(alignment: Alignment.center,
          children: [
            Container(
              height: 150,
              width: 130,
              decoration: BoxDecoration(shape:BoxShape.circle,image: DecorationImage(image: AssetImage('assets/tic-tac-toe.png'),fit: BoxFit.cover)),
            ),
            SpinKitPulse(color:Color(0xff50206c) ,size: 400,)
          ],
        ),
      ),

    );
  }
}