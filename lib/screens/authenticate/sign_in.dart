import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_with_flutter/services/auth.dart';
import 'package:firebase_with_flutter/utils/CustomsColors.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomsColors.c4,
      appBar: AppBar(
        backgroundColor: CustomsColors.c5,
        elevation: 0.0,
        title: Text('AppName',
            style: TextStyle(
                color: CustomsColors.c3, fontSize: 25, letterSpacing: 1.0)),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 20.0),
        width: 200,
        height: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30), color: CustomsColors.c7),
        child: ElevatedButton(
          onPressed: () async {
            dynamic result = await _authService.signInAnon();

            if (result == null) {
              print('Null Value for SignInAnon');
              // print(result);
            } else {
              print('Signed In');
              print(result);
              print(result.uid);
            }
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: CustomsColors.c7,
            elevation: 0,
          ),
          child: Text('Sign In Anon',
              style: TextStyle(
                  color: CustomsColors.c6, fontSize: 20, letterSpacing: 1.0)),
        ),
      ),
    );
  }
}
