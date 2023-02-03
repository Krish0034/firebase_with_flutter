import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../handler/ErrorHandler.dart';
import '../../utils/CustomsColors.dart';
import '../widgete/RoundButton.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreenState();
}

class _ForgetPassScreenState extends State<ForgetPassScreen> {

   final auth=FirebaseAuth.instance;
   final emailController = TextEditingController();
   late bool loading=false;
  @override
  Widget build(BuildContext context) {
    double _width=MediaQuery.of(context).size.width;
    double _height=MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:AppBar(
        leading:  IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text('Forget Password',style: TextStyle(
              color: CustomsColors.c3,
              fontSize: 26,
              letterSpacing: 1.0
          ),),
        ),
        backgroundColor: CustomsColors.c5,
      ),
      body:Padding(
        padding:EdgeInsets.all(30.0),
        child: Column(
          children: [
            SizedBox(height: _height/6,),
            TextFormField(
              maxLines: 2,
              cursorHeight:25,
              controller: emailController,
              decoration: InputDecoration(
                hintText: 'Enter Email',
                filled: true,
                fillColor: CustomsColors.c11.withOpacity(0.3),
                border: OutlineInputBorder(),
              ),
            ),

            SizedBox(height: _height/10,),
            RoundButton(
              loading: loading,
              onTap: () {
                setState(() {
                  loading=true;
                  emailController.clear();
                });
                auth.sendPasswordResetEmail(email: emailController.text.toString())
                    .then((value){
                      setState(() {
                        loading=false;
                      });
                      ErrorHandler().toastMessage('We Have Sent You Email To Recover Password, Please Check Own Email.');
                })
                    .onError((error, stackTrace){
                      setState(() {
                        loading=false;
                      });
                  ErrorHandler().toastMessage(error.toString());
                });
              },
              title: 'Forget',
              color: CustomsColors.c11,
            ),
          ],
        ),
      )
    );
  }
}
