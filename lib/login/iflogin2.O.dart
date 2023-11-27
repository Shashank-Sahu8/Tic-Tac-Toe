import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tictic/game_page.dart';

import 'login.dart';

class iflogin2 extends StatefulWidget {
  const iflogin2({super.key, this.player1, this.player2});
  final player1;
  final player2;
  @override
  State<iflogin2> createState() => _iflogin2State();
}

class _iflogin2State extends State<iflogin2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshort){
          if(snapshort.hasData)
          {
            return gamepage(player1: widget.player1, player2: widget.player2) ;
          }
          else
          {
            return login();
          }
        },
      ),
    );
  }
}
