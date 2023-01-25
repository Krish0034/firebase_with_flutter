
import 'dart:async';
import 'package:flutter/material.dart';
import '../screens/authenticate/login_screen.dart';

class SplashServices
{
  void isLogin(BuildContext context)
  {
    Timer( Duration(seconds: 6),(){
      Navigator.push(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
    });
  }
}