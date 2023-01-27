
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_with_flutter/handler/ErorrHandler.dart';
import 'package:firebase_with_flutter/screens/authenticate/login_screen.dart';
import 'package:firebase_with_flutter/screens/widgete/RoundButton.dart';
import 'package:firebase_with_flutter/utils/CustomsColors.dart';
import 'package:firebase_with_flutter/utils/PageBgColor.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../models/FriendList.dart';
import '../home/InstaHomePage.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {

  final emailControlle=TextEditingController();
  final passwordControlle=TextEditingController();
  final nameControlle=TextEditingController();
  FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey=GlobalKey<FormState>();
  bool loading=false;
  late String email='';
  late String password='';
  late String name='';

  late int length1=favorite.length;

  @override
  void dispose()
  {
    super.dispose();
  }

  Future<void> signUP() async {
    {
      setState(() {
        loading=true;
      });
      _auth.createUserWithEmailAndPassword(email: email, password: password).then((value)
     {
       Navigator.push(context, MaterialPageRoute(builder: (context)=>InstaHomePage()));
       setState(() {
         loading=false;
       });

     }).onError((error, stackTrace) {
        ErorrHandler().toastMessage(error.toString());
        setState(() {
          loading=false;
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
      onWillPop: ()async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: Center(
              child: Text('SignUp',style: TextStyle(
                  color: CustomsColors.c3,
                  fontSize: 27,
                  letterSpacing: 1.0
              ),),
            ),
            backgroundColor: CustomsColors.c5,
          ),
          body:SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height-50,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 50,),
                  Text('Instagram',style: TextStyle(
                      fontFamily: 'Calinea',
                      fontSize: 53,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 1.0,
                      color: CustomsColors.c3
                  ),),
                  const SizedBox(height: 10,),
                  Form(
                      key: _formKey,
                      child:Column(
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            width: 350,
                            height: 60,
                            decoration: BoxDecoration(
                                color: CustomsColors.c3,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:TextFormField(
                              style: TextStyle(
                                  fontSize: 22,
                                  color: CustomsColors.c6,
                                  letterSpacing: 0.7
                                // fontWeight: FontWeight.w
                              ),
                              controller: nameControlle,
                              onChanged: (val) {
                                setState(() => name = val);
                              },
                              cursorHeight: 30,
                              validator: (value){
                                if(value!.isEmpty)
                                {
                                  return 'Enter Name';
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.person,color: CustomsColors.c11),
                                hintText: 'Enter Name..',
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: CustomsColors.c3,
                                  ),                            borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Container(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            width: 350,
                            height: 60,
                            decoration: BoxDecoration(
                                color: CustomsColors.c3,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:TextFormField(
                              style: TextStyle(
                                  fontSize: 22,
                                  color: CustomsColors.c6,
                                  letterSpacing: 0.7
                                // fontWeight: FontWeight.w
                              ),
                              controller: emailControlle,
                              onChanged: (val) {
                                setState(() => email = val);
                              },
                              cursorHeight: 30,
                              validator: (value){
                                if(value!.isEmpty)
                                {
                                  return 'Enter Email';
                                }
                              },
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.login_outlined,color: CustomsColors.c11),
                                hintText: 'phone number, username or email address',
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: CustomsColors.c3,
                                  ),                            borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                          Container(
                            padding: EdgeInsets.only(left: 5,right: 5),
                            width: 350,
                            height: 60,
                            decoration: BoxDecoration(
                                color: CustomsColors.c3,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child:TextFormField(
                              style: TextStyle(
                                  fontSize: 22,
                                  color: CustomsColors.c6,
                                  letterSpacing: 0.7
                                // fontWeight: FontWeight.w
                              ),
                              controller: passwordControlle,
                              onChanged: (val) {
                                setState(() => password = val);
                              },
                              obscureText:true,
                              validator: (value) {
                                if(value!.isEmpty)
                                {
                                  return 'Enter Password';
                                }
                              },
                              obscuringCharacter: '*',
                              cursorHeight: 30,
                              decoration: InputDecoration(
                                prefixIcon: Icon(Icons.lock,color: CustomsColors.c13,),
                                hintText: 'password',
                                border: InputBorder.none,
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: CustomsColors.c3,

                                  ),
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 15,),
                        ],
                      )
                  ),
                  RoundButton(
                    title: 'SignUp',
                    loading: loading,
                    onTap:() {
                      if(_formKey.currentState!.validate())
                      {
                        signUP();
                      }
                      setState(() {

                        favorite[0].name=name;
                        nameControlle.clear();
                        emailControlle.clear();
                        passwordControlle.clear();
                      });
                    },
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: EdgeInsets.only(right: 5),
                        width: 120,
                        child: Divider(
                          thickness: 1.5,
                          color: CustomsColors.c10,
                        ),
                      ),
                      Text('OR',style: TextStyle(
                          color: CustomsColors.c10,
                          fontSize: 20
                      )
                        ,),
                      Container(
                        margin: EdgeInsets.only(left: 5),
                        width: 120,
                        child: Divider(
                          thickness: 1.5,
                          color: CustomsColors.c3,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.only(left: 65,right: 65),
                    child: TextButton(
                        onPressed:() {

                        },
                        child:Center(
                          child: Row(
                            children: [
                              Image.asset('assets/icon/facebook.png',width: 40,height: 30,color: CustomsColors.c3),
                              Text('Login With Facebook',style: TextStyle(
                                color: CustomsColors.c3,
                                fontSize: 18,
                                letterSpacing: 1.0,
                              ),),
                            ],
                          ),
                        )
                    ),
                  ),
                  const SizedBox(height: 60,),
                  Divider(
                    color: CustomsColors.c10,
                    thickness: 1.5,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Already have an accocunt?",style: TextStyle(color: CustomsColors.c6,fontSize: 19),),
                      TextButton(
                        onPressed:() {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginScreen()));
                        },
                        child:Center(
                          child:Text('LogIn',
                            style:TextStyle(
                                fontSize: 22,
                                letterSpacing: 0.4
                            ),),
                        ) ,
                      )
                    ],
                  )


                ],
              ),

            ),
          )
      ),
    );
  }
}
