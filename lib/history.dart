import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'login/login.dart';

class history extends StatefulWidget {
  const history({super.key});

  @override
  State<history> createState() => _historyState();
}
String uid=_auth.currentUser!.uid;
final _auth=FirebaseAuth.instance;
class _historyState extends State<history> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff1E3A4C),
      appBar: AppBar(
        centerTitle: true,
        title: Text("History",style: TextStyle(fontSize: 26,color: Colors.white54),),
        actions: [IconButton(onPressed: (){
          _auth.signOut();
          Navigator.pop(context);
        }, icon: Icon(Icons.logout_outlined))],
        backgroundColor: Color(0xff1E3A4C),
        elevation: 0,
        automaticallyImplyLeading: true,
        iconTheme: IconThemeData(color: Colors.blueGrey),
      ),
      body: SafeArea(
        child: SingleChildScrollView(scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0,right: 16.0),
                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Round",style: TextStyle(color: Colors.white60,fontSize: 20,fontWeight: FontWeight.w400),),
                    SizedBox(width: 20,),
                    Text("Winner",style: TextStyle(color: Colors.white60,fontSize: 20,fontWeight: FontWeight.w400),),
                    SizedBox(width: 20,),
                    Text("Looser",style: TextStyle(color: Colors.white60,fontSize: 20,fontWeight: FontWeight.w400),),
                    SizedBox(width: 20,),
                    Text("Time",style: TextStyle(color: Colors.white60,fontSize: 20,fontWeight: FontWeight.w400),)
                  ],
                ),
              ),
              Container(margin: EdgeInsets.only(bottom: 60),
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance.collection('tic tac toe').doc(uid).collection('Winner').snapshots(),
                  builder: (context,snapshots){
                    if(snapshots.connectionState==ConnectionState.waiting)
                    {
                      return const Center(child:CircularProgressIndicator(color: Colors.white,),);
                    }
                    else
                      {
                        final docs=snapshots.data!.docs;
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 50.0),
                              child: DottedBorder(
                                color: Colors.white38,
                                strokeWidth: 1.2,
                                strokeCap: StrokeCap.butt,
                                dashPattern: [3,0,3],
                                borderType: BorderType.RRect,
                                radius: Radius.circular(5),
                                child: ListView.builder(
                                    reverse:false,
                                    itemCount: docs.length,
                                    itemBuilder: (context,index){
                                     return Padding(
                                       padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                                       child: Column(
                                         children: [
                                           SizedBox(height: 10,),
                                           Row(
                                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                             children: [

                                               Text("Round ${index+1}"),
                                               SizedBox(width: 10,),
                                               Text(docs[index]['winner'].length>8?docs[index]['winner'].substring(0,8)+"...":docs[index]['winner'],style: TextStyle(color: Colors.white,fontSize: 18),),
                                               SizedBox(width: 40,),
                                               Text(docs[index]['looser'].length>8?docs[index]['looser'].substring(0,8)+"...":docs[index]['looser'],style: TextStyle(color: Colors.white,fontSize: 18),),
                                               SizedBox(width: 10,),
                                               Row(
                                                 children: [
                                                   Text(docs[index]['hour'],style: TextStyle(color: Colors.white,fontSize: 16),),
                                                   Text(":",style:TextStyle(color: Colors.white,fontSize: 18),),
                                                   Text(docs[index]['min'],style: TextStyle(color: Colors.white,fontSize: 16),),
                                                   Text(":",style:TextStyle(color: Colors.white,fontSize: 18),),
                                                   Text(docs[index]['sec'],style: TextStyle(color: Colors.white,fontSize: 16),),
                                                 ],
                                               )
                                             ],
                                           ),
                                           SizedBox(height: 5,),
                                           Divider(color: Colors.white30,)
                                         ],
                                       ),
                                     );
                                    }),
                              ),
                            ),
                          ),
                        );
                      }
                  },
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}





// stream: FirebaseFirestore.instance.collection('tic tac toe').doc(uid).collection('Winner').snapshots(),
