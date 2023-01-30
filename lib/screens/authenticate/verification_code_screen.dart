
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_with_flutter/screens/home/InstaHomePage.dart';
import 'package:firebase_with_flutter/utils/CustomsColors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../handler/ErorrHandler.dart';
import '../widgete/RoundButton.dart';

///********** Add Device FingerePrint in Firebase Project And Cmd is
///***** keytool -list -v -keystore "C:\Users\Krishn\.android\debug.keystore" -alias androiddebugkey -storepass android -keypass android

class VerificationCodeScreen extends StatefulWidget {
  String verificationId;
  VerificationCodeScreen({Key? key,required this.verificationId}) : super(key: key);

  @override
  State<VerificationCodeScreen> createState() => _VerificationCodeScreenState();
}

class _VerificationCodeScreenState extends State<VerificationCodeScreen> {
  final phoneNumberController= TextEditingController();
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
          title: Center(child: Text('Verification Page',style: TextStyle(
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
               color: CustomsColors.c11
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Enter phone number code
                Padding(
                  padding: const EdgeInsets.only(left: 15,right: 15),
                  child: TextFormField(
                    controller:phoneNumberController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      return 'Enter valid Pin';
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
                        prefixIcon:Icon(Icons.pin,color: CustomsColors.c6.withOpacity(0.6)),
                        hintText: 'Enter 6 digit Pin',
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
                  title: 'Verify',
                  onTap:() async{
                    final credential= PhoneAuthProvider.credential(
                        verificationId: widget.verificationId,
                        smsCode:phoneNumberController.text.toString()
                    );
                    setState(() {
                      loading=true;
                    });
                    try
                    {
                      await auth.signInWithCredential(credential);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> InstaHomePage()));
                    }
                    catch(e)
                    {
                      setState(() {
                        loading=false;
                      });
                      ErorrHandler().toastMessage(e.toString());

                    }
                  },
                ),
              ],
            ),
          ),
        )
    );
  }
}
