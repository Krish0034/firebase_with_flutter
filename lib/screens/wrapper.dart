import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_with_flutter/screens/authenticate/authenticate.dart';
import 'package:firebase_with_flutter/screens/home/home.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // return eiither Home or Athenticatee
    //return Home();
    return FutureBuilder(
        future: Firebase.initializeApp(),
        builder: (context, snapshot) {
          return Authenticate();
        });
  }
}
