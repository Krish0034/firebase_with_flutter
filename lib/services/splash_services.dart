
import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../models/FriendList.dart';
import '../screens/authenticate/login_screen.dart';
import '../screens/home/InstaHomePage.dart';

class SplashServices
{
  void isLogin(BuildContext context)
  {
    final auth = FirebaseAuth.instance;
    final user=auth.currentUser;
    if(user !=null)
    {
      Timer(const Duration(seconds: 3),() => Navigator.push(context, MaterialPageRoute(builder: (context)=>InstaHomePage()))) ;
    }
    else
      {
        Timer( Duration(seconds: 6),(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
        });
      }

  }
}