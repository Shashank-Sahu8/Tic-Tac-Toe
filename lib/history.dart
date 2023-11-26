import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login/login.dart';

class history extends StatefulWidget {
  const history({super.key});

  @override
  State<history> createState() => _historyState();
}
final _auth=FirebaseAuth.instance;
class _historyState extends State<history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.blueGrey),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: (){
            _auth.signOut();
            utils().toastmess("Successful Log Out");
          }, child: Text("logout?"),
        ),
      ),
    );
  }
}
