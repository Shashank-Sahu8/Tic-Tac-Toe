import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:icons_plus/icons_plus.dart';
import 'login.dart';

class signup extends StatefulWidget {
  const signup({super.key});

  @override
  State<signup> createState() => _signupState();
}

class _signupState extends State<signup> {
  final formfield=GlobalKey<FormState>();
  final emailcontroller=TextEditingController();
  final passwordcontroller=TextEditingController();
  final confirmpasswordcontroller=TextEditingController();
  bool loading=false;
  FirebaseAuth _auth=FirebaseAuth.instance;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    emailcontroller.dispose();
    passwordcontroller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(automaticallyImplyLeading: true,iconTheme: IconThemeData(color: Colors.blueGrey),),
      backgroundColor:Theme.of(context).colorScheme.background,
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    SizedBox(height: 50,),
                    Text("Sign Up",textAlign: TextAlign.center,style: TextStyle(fontSize: 36,fontWeight: FontWeight.w700,color:Theme.of(context).colorScheme.onPrimaryContainer),),
                    SizedBox(height: 10,),
                    //Image.asset('assets/key-with-padlock-icon-in-comic-style-access-login-vector-cartoon-illustration-pictogram-lock-keyhole-business-concept-splash-effect-rbc5ej-removebg-preview.png',fit: BoxFit.cover,),
                  ],
                ),
                Form(
                    key: formfield,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 15.0,left: 7.0),
                      child: Column(

                        children: [
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            cursorColor: Colors.orange,
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
                            cursorColor: Colors.blueGrey,
                            obscureText: true,
                            controller: passwordcontroller,
                            decoration: InputDecoration(
                                hintText: "Password",
                                helperText: "Name@123...",
                                icon: Icon(Bootstrap.keyboard,color: Colors.blueGrey,)),
                            validator: (value){if(value!.isEmpty){return 'Enter password';}return null;},
                          ),
                          SizedBox(height: 20,),
                          TextFormField(
                            keyboardType: TextInputType.text,
                            cursorColor: Colors.blueGrey,
                            obscureText: true,
                            controller: confirmpasswordcontroller,
                            decoration: InputDecoration(
                                hintText: "Confirm Password",
                                helperText: "Name@123...",
                                icon: Icon(Bootstrap.keyboard,color: Colors.blueGrey,)),
                            validator: (value){
                              if(value!.isEmpty){return 'Enter password again';}return null;},
                          )
                        ],
                      ),
                    )
                ),
                SizedBox(height: 10,),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: ElevatedButton(

                      style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xff03002e),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))) ,

                      onPressed: () {
                        // if(passwordcontroller!=confirmpasswordcontroller)
                        // {
                        //   Future.error(Text("Password Incorrect"));
                        // }
                        if (formfield.currentState!.validate()) {
                          // if(passwordcontroller!=confirmpasswordcontroller)
                          //   {
                          //     return utils().toastmess("Password not matched");
                          //   }
                          // else
                          //   {
                          showDialog(context: context, builder: (context) {
                            return const Center(
                              child: CircularProgressIndicator(),);
                          });
                          _auth.createUserWithEmailAndPassword(
                              email: emailcontroller.text.toString(),
                              password: passwordcontroller.text.toString())
                              .then((value) {Navigator.pop(context);
                            utils().toastmess("Sign Up successfully");
                            Navigator.pop(context);
                            // LocalNotifications.showSimpleNotification(title: 'To_Do',body: 'Successful Log In',payload: 'hello');
                          }).onError((error, stackTrace) {
                            utils().toastmess(error.toString());
                          });
                        }
                        }

                      , child: Container(height: 50,child: Row(crossAxisAlignment: CrossAxisAlignment.center,mainAxisAlignment: MainAxisAlignment.center,children: [Icon(Icons.login),SizedBox(width: 10,),Text("Sign up")],),)),
                ),

                SizedBox(height: 20,),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have account?",style: TextStyle(fontSize: 15,color: Theme.of(context).colorScheme.onPrimaryContainer),),
                      TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>login()));}, child: Text("Login",style: TextStyle(color:  Theme.of(context).colorScheme.tertiary),))
                    ],
                  ),
                ),

              ],
            ),
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
        textColor: Colors.orange,
        fontSize: 16.0
    );
  }

}