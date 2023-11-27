import 'dart:async';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictic/homepage.dart';
import 'package:easy_count_timer/easy_count_timer.dart';
import 'login/if_login.dart';
import 'login/login.dart';

class gamepage extends StatefulWidget {
  const gamepage({super.key, required this.player1, required this.player2});
  final  player1;
  final  player2;
  @override
  State<gamepage> createState() => _gamepageState();
}
final _auth=FirebaseAuth.instance;
String uid=_auth.currentUser!.uid;
class _gamepageState extends State<gamepage> {

  late Timer _timer;
  var __controller = CountTimerController();

  // adduser()async{
  //   print(uid.toString());
  //   print(time.toString());
  //   // await FirebaseFirestore.instance
  //   //     .collection('data')
  //   //     .add({'text': 'data added through app'});
  //   await FirebaseFirestore.instance.collection('tic tac toe').doc(uid.toString()).collection('Winner').doc(time.toString()).set({'winner':widget.player1.toString(),'looser':widget.player2.toString(),'hour':hstr.toString(),'min':mstr.toString(),'sec':sstr.toString()});
  //  //{'winner':_winner=="X"?widget.player1.toString():widget.player2.toString(),'looser':_winner=="X"?widget.player2.toString():widget.player1.toString()}
  // utils().toastmess("doe");
  // }
  late List<List<String>>_board;
  late String _currentplayer;
  late String _winner;
  late bool _gameover;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _board=List.generate(3, (index) => List.generate(3,(_)=>""));
    _currentplayer="X";
    _winner="";
    _gameover=false;
    starttimer();
  }

  void _reset()
  {_timer.cancel();
    setState(() {
      _board=List.generate(3, (_) => List.generate(3,(_)=>""));
      _currentplayer="X";
      _winner="";
      _gameover=false;
      sec=0;
      min=0;
      hour=0;
      sstr="00";
      mstr="00";
      hstr="00";
    });
    starttimer();
  }
  void move(int row,int col)
  {
    if(_board[row][col]!=""||_gameover)
      {
        return;
      }
    setState(()   {
      _board[row][col]=_currentplayer;
      if(_board[row][0] == _currentplayer && _board[row][1] == _currentplayer && _board[row][2] == _currentplayer)
        {
          _winner=_currentplayer;
          _gameover=true;
        }
      else if(_board[0][col] == _currentplayer && _board[1][col] == _currentplayer && _board[2][col] == _currentplayer)
        {
          _winner=_currentplayer;
          _gameover=true;
        }
      else if(_board[0][0] == _currentplayer && _board[1][1] == _currentplayer && _board[2][2] == _currentplayer)
      {
        _winner=_currentplayer;
        _gameover=true;
      }
      else if(_board[0][2] == _currentplayer && _board[1][1] == _currentplayer && _board[2][0] == _currentplayer)
      {
        _winner=_currentplayer;
        _gameover=true;
      }
     // else if(_board[0][0]==_currentplayer&&_board[1][0]==_currentplayer&&_board[0][0]==_currentplayer)
      else if(!_board.any((row) => row.any((cell) => cell==""))){
        _gameover=true;
        _winner="Tie";
      }
      //  if(!_board.any((row) => row.any((cell) => cell==""))){
      //   _gameover=true;
      //   _winner="Tie";
      // }
      _currentplayer=_currentplayer=="X"?"O":"X";
      if(_winner!="")
        {
          _timer.cancel();
          var time=DateTime.now();
          // !doc.exists? FirebaseFirestore.instance.collection('tic tac toe').doc(uid.toString()).collection('Winner').doc(time.toString()).update({'winner':_winner=="X"?widget.player1:_winner=="O"?widget.player2:"Tie",'looser':_winner=="X"?widget.player2:_winner=="O"?widget.player1:"Tie",'hour':hstr.toString(),'min':mstr.toString(),'sec':sstr.toString()}):
            FirebaseFirestore.instance.collection('tic tac toe').doc(uid.toString()).collection('Winner').doc(time.toString()).set({'winner':_winner=="X"?widget.player1:_winner=="O"?widget.player2:"Tie",'looser':_winner=="X"?widget.player2:_winner=="O"?widget.player1:"Tie",'hour':hstr.toString(),'min':mstr.toString(),'sec':sstr.toString()});

          print( _winner=="X"?widget.player1+"Won":_winner=="O"?widget.player2+"Won":"Tie,better Luck next time");
          AwesomeDialog(
            context: context,
            dialogType: DialogType.success,
            animType: AnimType.rightSlide,
            btnOkText: "Play Again?",
            title:  _winner=="X"?widget.player1+"Won":_winner=="O"?widget.player2+"Won":"Tie,better Luck next time",
            btnOkOnPress: (){
              _reset();
            }
          )..show();
        }
    });
  }

  String hstr="00",mstr="00",sstr="00";

  int hour=0,min=0,sec=0;
  void starttimer()
  {

    hour=0;min=0;sec=0;
    _timer=Timer.periodic(Duration(seconds: 1) ,(time){
      setState(() {
       if(sec<59)
         {
           sec++;
           sstr=sec.toString();
           if(sstr.length==1)
             sstr="0"+sec.toString();
         }
       else
         {
           startmin();
         }
      });
    });
  }
  void startmin()
  {
    setState(() {
      if(min<59)
        {
          sec=0;
          sstr="00";
          min++;
          mstr=min.toString();
          if(mstr.length==1)
            mstr="0"+min.toString();
        }
      else
        {
          hourstart();
        }
    });
  }

  void hourstart()
  {
    setState(() {
      if(hour<12)
        {
          min=0;
          sec=0;
          sstr;"00";
          mstr="00";
          hour++;
          hstr=hour.toString();
          if(hstr.length==1)
            hstr="0"+hour.toString();
        }
      else
        {
          AwesomeDialog(
              context: context,
              dialogType: DialogType.warning,
              animType: AnimType.rightSlide,
              btnOkText: "Play Again?",
              title:  "Oops! Time Up",
              btnOkOnPress: (){
                _reset();
              }
          )..show();
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E3A4C),
      body: SafeArea(
        child: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(children: [
            Row(mainAxisAlignment:MainAxisAlignment.end,children: [TextButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>islogin()));}, child: Text("History"))],),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 28.0,right: 28.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                Text("Turn : ",style: GoogleFonts.montserrat(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                Expanded(
                  child: Text(
                    _currentplayer=="X"?widget.player1.toString().length>8?widget.player1.toString().substring(0,8)+"...":widget.player1:widget.player2.toString().length>8?widget.player2.toString().substring(0,8)+"...":widget.player2,
                      style: GoogleFonts.montserrat(color: Colors.white,fontSize: 26,fontWeight: FontWeight.w600),
                  ),
                ),
                Text("( $_currentplayer )",style: GoogleFonts.montserrat(color: _currentplayer=="X"?Colors.red:Colors.black,fontSize: 26,fontWeight: FontWeight.w600),)
              ],),
            ),

            SizedBox(height: 50,),
            Container(
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                borderRadius: BorderRadius.circular(10)
              ),
              margin: EdgeInsets.all(5),
              child: GridView.builder(
                itemCount: 9,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                  itemBuilder:(context,index){
                  int row=index~/3;
                  int col=index%3;
                  return GestureDetector(
                    onTap: (){move(row, col);},
                    child: Container(
                      margin: EdgeInsets.all(4),
                      decoration: BoxDecoration(
                        color:Colors.lightBlue,
                        borderRadius: BorderRadius.circular(10)
                      ),
                      child: Center(child: Text(_board[row][col],style: TextStyle(fontSize: 80,fontWeight: FontWeight.bold,color: _currentplayer=="X"?Colors.red:Colors.black ),)),
                    ),
                  );
                  } ),
            ),
            SizedBox(height: 20,),
             Text(" $hstr : $mstr : $sstr",style: TextStyle(color: Colors.white,fontSize: 29),),
            // CountTimer(
            //   colonsTextStyle: TextStyle(color: Colors.white,fontSize: 26),
            //   timeTextStyle: TextStyle(color: Colors.white,fontSize: 26),
            //   descriptionTextStyle: TextStyle(color: Colors.white),
            //   daysDescription: "day",
            //   hoursDescription: "hour",
            //   minutesDescription: "minutes",
            //   secondsDescription: "seconds",
            //   format: CountTimerFormat.hoursMinutesSeconds,
            //   controller:CountTimerController(),
            // ),
            SizedBox(height: 30),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(onTap: (){setState(() {
                   _reset();
                });},
                  child: Container(height: 60,width: 130,
                    child: Card(
                      semanticContainer: true,
                      color: Colors.greenAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Center(child: Text("Play Again"),),
                    ),
                  ),
                ),
                GestureDetector(onTap: (){setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>homepage()));
                });},
                  child: Container(height: 60,width: 130,
                    child: Card(
                      semanticContainer: true,
                      color: Colors.greenAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                      child: Center(child: Text(" Home "),),
                    ),
                  ),
                ),
              ],
            )

          ],),
        ),
      ),
    );
  }
}
