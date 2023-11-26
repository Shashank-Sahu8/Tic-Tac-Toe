import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tictic/history.dart';

import 'login.dart';
class islogin extends StatelessWidget {
  const islogin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context,snapshort){
          if(snapshort.hasData)
          {
            return history() ;
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
