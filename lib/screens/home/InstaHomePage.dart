import 'package:firebase_with_flutter/utils/CustomsColors.dart';
import 'package:flutter/material.dart';

import '../../utils/MyFlutterApp.dart';
import '../widgete/FriendListWidget.dart';

class InstaHomePage extends StatefulWidget {
  const InstaHomePage({Key? key}) : super(key: key);

  @override
  State<InstaHomePage> createState() => _InstaHomePageState();
}

class _InstaHomePageState extends State<InstaHomePage> {
  @override
  Widget build(BuildContext context) {
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
            fontFamily: 'Calinea'

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
                    color: CustomsColors.c6,
                  ),
                ),
              ),
            ),
          SizedBox(width: 5,),
          Material(
            type: MaterialType.transparency,
            child: Ink(
              child:InkWell(
                  onTap: () {},
                  child:Ink.image(image:AssetImage('assets/icon/heart.png'),height: 24,width: 24,)
              )
            ),
          ),
          SizedBox(width: 5,),
          Material(
            type: MaterialType.transparency,
            child: Ink(
              child: InkWell(
                  onTap: () {},
                  child:Ink.image(image:AssetImage('assets/icon/massen.jpg',),height: 24,width: 24,)
              ),
            ),
          ),
        ]),
      backgroundColor: CustomsColors.c3,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FriendListWidget(),
        ],
      )
    );
  }
}
