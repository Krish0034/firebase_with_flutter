import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_with_flutter/handler/ErorrHandler.dart';
import 'package:firebase_with_flutter/screens/authenticate/login_screen.dart';
import 'package:firebase_with_flutter/utils/CustomsColors.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../models/FriendList.dart';
import '../../utils/MyFlutterApp.dart';
import '../widgete/FriendListWidget.dart';
import '../widgete/HomePageMaterial.dart';

class InstaHomePage extends StatefulWidget {
//  String name;

  InstaHomePage({Key? key}) : super(key: key);

  @override
  State<InstaHomePage> createState() => _InstaHomePageState();
}


class _InstaHomePageState extends State<InstaHomePage> {

 FirebaseAuth auth=FirebaseAuth.instance;
  bool isLiked =false;
  int likeCount=0;
  int length=favorite.length;

  @override
  Widget build(BuildContext context) {
    final double size=30;
    return Scaffold(
      appBar:AppBar(
        toolbarHeight: 100,
        automaticallyImplyLeading: false,
        backgroundColor: CustomsColors.c3,
        title:Text('Instagram',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 38,
            letterSpacing: .8,
            fontFamily: 'Calinea',
            color: CustomsColors.c6
          ),

        ),
        elevation: 0.0,
        actions: [
          Material(
            type: MaterialType.transparency,
            child: Ink(
              child: InkWell(
                onTap: () {},
                child:Icon(
                  Icons.add_box,
                  size: 30.0,
                  color: CustomsColors.c6.withOpacity(0.7),
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Material(
            type: MaterialType.transparency,
            child: Ink(
              child: InkWell(
                onTap: () {},
                child:Icon(
                  Icons.favorite_border,
                  size: 30.0,
                  color: CustomsColors.c6.withOpacity(0.7),
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Material(
            type: MaterialType.transparency,
            child: Ink(
              child: InkWell(
                onTap: () {},
                child:Icon(
                  Icons.send,
                  size: 30.0,
                  color: CustomsColors.c6.withOpacity(0.7),
                ),
              ),
            ),
          ),
          SizedBox(width: 5,),
          Material(
            type: MaterialType.transparency,
            child: Ink(
              child: InkWell(
                onTap: () {
                  auth.signOut().then((value){
                    Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                  }).onError((error, stackTrace){
                    ErorrHandler().toastMessage(error.toString());
                  });
                },
                child:Icon(
                  Icons.logout,
                  size: 30.0,
                  color: CustomsColors.c6.withOpacity(0.7),
                ),
              ),
            ),
          ),
        ]),
      backgroundColor: CustomsColors.c3,
      body: ListView(
        //mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 120,
            color: CustomsColors.c3,
            child: FriendListWidget(direction:Axis.horizontal,length:length,),
          ),
          Container(
              height: 400,
              //color: CustomsColors.c14,
              child: HomePageMaterial()
         ),
        ],
      )
    );
  }
  // Widget countBuilder(int likeCount,bool isLiked,Text text)
  // {
  //   final color = CustomsColors.red:
  // }
}
