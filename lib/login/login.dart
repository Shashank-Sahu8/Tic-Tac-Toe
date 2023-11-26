import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:tictic/login/signup.dart';

import 'forgetpassword.dart';
class login extends StatefulWidget {

  const login({super.key});

  @override
  State<login> createState() => _loginState();
}
bool obtext=false;
final  _auth = FirebaseAuth.instance;
String? uid=_auth.currentUser?.uid;

class _loginState extends State<login> {
  var time=DateTime.now();
  bool loading=false;
  final _formfield=GlobalKey<FormState>();
  final emailcontroller=TextEditingController();
  final password=TextEditingController();

  void login() async{
    showDialog(context: context, builder: (context){return const Center(child: CircularProgressIndicator(),);});
    setState(() {
      loading=true;
    });
    await _auth.signInWithEmailAndPassword(email: emailcontroller.text, password: password.text.toString()).then((value){
      utils().toastmess("Login Successfully");
      //LocalNotifications.showSimpleNotification(title: 'To_Do',body: 'Successful Log In',payload: 'hello');
      setState(() {
        loading=false ;
      });
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>pagepage()));
      utils().toastmess(value.user!.email.toString());}).onError((error, stackTrace) {
      setState(() {
        loading=false;
      });debugPrint(error.toString());utils().toastmess(error.toString());});
  }

  ad()async{utils().toastmess("doe");
  print("no user");
  await FirebaseFirestore.instance.collection('test').doc(uid).set({'ClassName':emailcontroller.text.toString(),'ClassId':password.text.toString()});
  utils().toastmess("new user");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(automaticallyImplyLeading: true,iconTheme: IconThemeData(color: Colors.blueGrey),),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 80,),
              Text("Login",textAlign: TextAlign.center,style: TextStyle(fontSize: 36,fontWeight: FontWeight.w700,color: Theme.of(context).colorScheme.onPrimaryContainer),),
              SizedBox(height: 50,),
              Form(
                  key: _formfield,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 7.0),
                    child: Column(

                      children: [
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: Theme.of(context).colorScheme.tertiary,
                          controller: emailcontroller,
                          decoration: InputDecoration(
                              hintText: "Email",
                              helperText: "e.g. example@gmail.com",
                              icon: Icon(Icons.email,color: Colors.blueGrey,)),
                          validator: (value){if(value!.isEmpty){return 'Enter email';}return null;},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Theme.of(context).colorScheme.tertiary,
                          obscureText: obtext,
                          controller: password,
                          decoration: InputDecoration(
                              hintText: "Password",
                              helperText: "Name@123...",
                              icon: IconButton(icon:Icon(obtext!=false?Bootstrap.eye_fill:Bootstrap.eye_slash,color: Colors.blueGrey,) ,onPressed: (){setState(() {
                                setState(() {
                                  obtext=!obtext;
                                });
                              });},)),
                          validator: (value){if(value!.isEmpty){return 'Enter password';}return null;},
                        )
                      ],
                    ),
                  )
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>forgetpass()));}, child: Text("Forget Password?",style: TextStyle(color: Theme.of(context).colorScheme.tertiary),)),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left:20.0,top: 10,right: 20.0,bottom: 20.0),
                child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))) ,

                    onPressed: () {
                  //ad();
                      if(_formfield.currentState!.validate()){
                        login();}
                        //adduser();
                        // final snapshot= FirebaseFirestore.instance.doc(uid.toString()).collection('marks').doc('user').collection('user_mail').get();
                        // if(snapshot.toString().isEmpty)
                        //   {
                        //     adduser();
                        //   }
                        // else
                        //   {
                        //     updateuser();
                        //   }
                      //}
                    }

                    , child: Container(height: 50,child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.login),SizedBox(width: 10,),Text("Login")],),)),
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have account?",style: TextStyle(color: Colors.blueGrey),),
                  TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));}, child: Text("Sign Up",style: TextStyle(color: Theme.of(context).colorScheme.tertiary),))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
class utils{

  toastmess(String message)
  {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.grey[700],
        textColor:  Color(0xff733E9E),
        fontSize: 16.0
    );
  }

}
