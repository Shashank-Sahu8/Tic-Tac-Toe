import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:icons_plus/icons_plus.dart';
import 'game_page.dart';
import 'login/iflogin2.O.dart';

class homepage extends StatefulWidget {
  const homepage({super.key});

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  final GlobalKey<FormState>_formKey=GlobalKey<FormState>();
  final TextEditingController player1=TextEditingController();
  final TextEditingController player2=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E3A4C),
      body: SafeArea(
        child: Container(
          child: SingleChildScrollView(scrollDirection: Axis.vertical,
            child: Column(mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 70,),
                CircleAvatar(backgroundImage: AssetImage('assets/tic-tac-toe-fotor-2023111210659.png'),radius: 50),
                SizedBox(height: 50,),
                Text("Enter Players Name",style: GoogleFonts.montserrat(fontSize: 28,fontWeight: FontWeight.w700,color:Colors.white,shadows: <Shadow>[Shadow(offset: Offset(1, 1),blurRadius: 6,color: Colors.blueAccent)]),),
                SizedBox(height: 40,),
                Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 15.0,left: 15.0),
                    child: Column(
                      children: [
                        TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.blueGrey,
                          controller: player1,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey)),
                              hintText: "Player 1",
                              hintStyle: TextStyle(color: Colors.blueGrey),
                              icon: Icon(FontAwesome.user_ninja,color: Colors.grey,)),
                          validator: (value){if(value!.isEmpty){return 'Enter Player name';}return null;},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          keyboardType: TextInputType.text,
                          cursorColor: Colors.pinkAccent,
                          controller: player2,
                          style: TextStyle(color: Colors.white),
                          decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                              focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                              enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.blueGrey)),
                              hintText: "Player 2",

                              fillColor: Colors.white,
                              focusColor: Colors.white,
                              hintStyle: TextStyle(color: Colors.blueGrey),
                              icon: Icon(FontAwesome.user_ninja,color: Colors.grey,)),
                          validator: (value){if(value!.isEmpty){return 'Enter Player name';}return null;},
                        ),
                          SizedBox(height: 40,),
                          ElevatedButton(onPressed: (){
                            if(_formKey.currentState!.validate()){
                              Navigator.push(context,MaterialPageRoute(builder: (context)=>iflogin2(player1: player1.text, player2: player2.text,)));
                            }
                          },style: ElevatedButton.styleFrom(
                              elevation: 8,
                              shadowColor: Colors.grey,
                              minimumSize: Size(0, 53),maximumSize: Size(280, 53),shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),backgroundColor: Colors.white), child: Row(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Start Now",style: TextStyle(fontSize: 21,color: Color(0xff1E3A4C)),),
                              Icon(Icons.arrow_forward_outlined,color: Color(0xff1E3A4C),)
                            ],
                          ))
                      ],
                    ),
                  )
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
