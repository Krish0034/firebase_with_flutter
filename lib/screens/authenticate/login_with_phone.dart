import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_with_flutter/handler/ErrorHandler.dart';
import 'package:firebase_with_flutter/screens/authenticate/verification_code_screen.dart';
import 'package:firebase_with_flutter/screens/widgete/RoundButton.dart';
import 'package:firebase_with_flutter/utils/CustomsColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/PageBgColor.dart';

class LoginWithPhoneNumber extends StatefulWidget {
  const LoginWithPhoneNumber({Key? key}) : super(key: key);

  @override
  State<LoginWithPhoneNumber> createState() => _LoginWithPhoneNumberState();
}

class _LoginWithPhoneNumberState extends State<LoginWithPhoneNumber> {
  final phoneController =TextEditingController();
  bool loading=false;
  final auth=FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: CustomsColors.c5,
        elevation: 0.3,
        title: Center(child: Text('Loging With Phone Number',style: TextStyle(
            color: CustomsColors.c3,
            fontSize: 20,
            letterSpacing: 1.0
        ),),),
      ),
      body:SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-90,
          decoration:BoxDecoration(
              gradient: LinearGradient(
                  colors: [
                    PageBgColor.c6,
                    PageBgColor.c1,
                    PageBgColor.c3,
                    PageBgColor.c2,
                    PageBgColor.c4,
                  ]
              )
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Enter phone number code
              Padding(
                padding: const EdgeInsets.only(left: 15,right: 15),
                child: TextFormField(
                  controller:phoneController,
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    return 'Enter valid Phone Number';
                  },
                  cursorHeight: 30,
                  style: TextStyle(
                    color:  CustomsColors.c6,
                    fontSize: 22,
                    letterSpacing: 1.0,

                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: CustomsColors.c3,
                    prefixIcon:Icon(Icons.phone_android,color: CustomsColors.c6.withOpacity(0.6)),
                    hintText: 'Enter Phone Number',
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                        borderSide: BorderSide(color: CustomsColors.c11,width: 2)
                    ),
                    border:OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                      borderSide: BorderSide(color: CustomsColors.c11,width: 2)

                    )
                  ),

                ),
              ),
              SizedBox(height: 50,),
              // Login Button Code
              RoundButton(
                  loading: loading,
                  title: 'Login',
                  onTap:() {
                    setState(() {
                      loading=true;
                    });
                    auth.verifyPhoneNumber(
                        phoneNumber: phoneController.text,
                        verificationCompleted: (_)
                        {
                          setState(() {
                            loading=false;
                          });
                        },
                        verificationFailed: (e) {
                          setState(() {
                            loading=false;
                          });
                          ErrorHandler().toastMessage(e.toString());
                        },
                        codeSent: (verificationId, forceResendingToken) {
                          setState(() {
                            loading=false;
                          });
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>VerificationCodeScreen(verificationId:verificationId)));
                        },
                        codeAutoRetrievalTimeout:(v) {
                          setState(() {
                            loading=false;
                          });
                          ErrorHandler().toastMessage(v.toString());
                        },
                    );
                  },
              ),
            ],
          ),
        ),
      )
    );
  }
}
