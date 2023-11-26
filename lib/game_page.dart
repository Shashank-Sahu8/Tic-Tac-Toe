import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictic/homepage.dart';

class gamepage extends StatefulWidget {
  const gamepage({super.key, required this.player1, required this.player2});
  final  player1;
  final  player2;
  @override
  State<gamepage> createState() => _gamepageState();
}

class _gamepageState extends State<gamepage> {
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
  }

  void _reset()
  {
    setState(() {
      _board=List.generate(3, (_) => List.generate(3,(_)=>""));
      _currentplayer="X";
      _winner="";
      _gameover=false;
    });
  }
  void move(int row,int col)
  {
    if(_board[row][col]!=""||_gameover)
      {
        return;
      }
    setState(() {
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
          print( _winner=="X"?widget.player1+"Won":_winner=="O"?widget.player2+"Won":"Tie,better Luck next time");
          //_reset();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E3A4C),
      body: SafeArea(
        child: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(children: [
            Row(mainAxisAlignment:MainAxisAlignment.end,children: [TextButton(onPressed: (){}, child: Text("History"))],),
            SizedBox(height: 30,),
            Padding(
              padding: const EdgeInsets.only(left: 28.0,right: 28.0),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,children: [
                Text("Turn : ",style: GoogleFonts.montserrat(color: Colors.white,fontSize: 30,fontWeight: FontWeight.bold),),
                Expanded(
                  child: Text(
                    _currentplayer=="X"?widget.player1.toString().length>8?widget.player1.toString().substring(0,8)+"...":widget.player2:widget.player2.toString().length>8?widget.player2.toString().substring(0,8)+"...":widget.player2,
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
            SizedBox(height: 30,),

            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(onTap: (){setState(() {
                  _reset();
                });},
                  child: Container(height: 50,width: 100,
                    child: Card(
                      semanticContainer: true,
                      color: Colors.greenAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      child: Center(child: Text("Play Again"),),
                    ),
                  ),
                ),
                GestureDetector(onTap: (){setState(() {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>homepage()));
                });},
                  child: Container(height: 50,width: 100,
                    child: Card(
                      semanticContainer: true,
                      color: Colors.greenAccent,
                      elevation: 5,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
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
