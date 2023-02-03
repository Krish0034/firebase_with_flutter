import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_with_flutter/screens/authenticate/signup_screen.dart';
import 'package:firebase_with_flutter/utils/CustomsColors.dart';
import 'package:firebase_with_flutter/utils/PageBgColor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


import '../../handler/ErrorHandler.dart';
import '../../models/FriendList.dart';
import '../home/InstaHomePage.dart';
import '../widgete/RoundButton.dart';
import 'ForgetPassScreen.dart';
import 'login_with_phone.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  FirebaseAuth _auth=FirebaseAuth.instance;

  final _formKey=GlobalKey<FormState>();
  final emailControlle=TextEditingController();
  final passwordControlle=TextEditingController();
  bool loading=false;

  String email='';
  String password='';



  @override
  void dispose()
  {
    super.dispose();
    emailControlle.dispose();
    passwordControlle.dispose();
  }
  void logIn()
  {
    final user=_auth.currentUser;
    final name=user?.displayName;
    setState(() {
      loading=true;
    });
    _auth.signInWithEmailAndPassword(
      email: emailControlle.text,
      password: passwordControlle.text.toString(),
    ).then((value){
      ErrorHandler().toastMessage(value.user!.email.toString());
      Navigator.push(context, MaterialPageRoute(builder: (context)=>InstaHomePage()));
      setState(() {
        loading=false;
      });
    }).onError((error, stackTrace)
    {
      ErrorHandler().toastMessage(error.toString());
      setState(() {
        loading=false;
      });
    }
    );
  }
  @override
  Widget build(BuildContext context) {
    double _width=MediaQuery.of(context).size.width;
    double _height=MediaQuery.of(context).size.height;
    return  WillPopScope(
      onWillPop: () async{
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Center(
            child: Text('LogIn',style: TextStyle(
              color: CustomsColors.c3,
              fontSize: 26,
              letterSpacing: 1.0
            ),),
          ),
          backgroundColor: CustomsColors.c5,
        ),
        body:Container(
          width: _width,
          height: _height-90,
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
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: _height/22.8,),
                // Instagram heading
                Text('Instagram',style: TextStyle(
                  fontFamily: 'Calinea',
                  fontSize: 53,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 1.0,
                  color: CustomsColors.c3
                ),),
                SizedBox(height: _height/91.2,),
                // TextFormField
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
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (val) {
                              setState(() => email = val);
                            },
                            controller:emailControlle ,
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
                                ),
                                borderRadius: BorderRadius.circular(10.0),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20,),
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
                            keyboardType: TextInputType.text,
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
                        const SizedBox(height: 20,),
                      ],
                    )
                ),
                //Forget Password
                Padding(
                  padding: const EdgeInsets.only(right: 15,top: 2),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: TextButton(
                       style: ButtonStyle(
                          overlayColor: MaterialStateColor.resolveWith((states) => Colors.green),
                        ),
                        onPressed: (){
                         Navigator.push(context,MaterialPageRoute(builder: (context)=>ForgetPassScreen()));
                        },
                        child:Text('Forget Password',style: TextStyle(height: 0,fontSize: 17,color: CustomsColors.c4,letterSpacing: 1.0),)
                    ),
                  ),
                ),

                // Login Button
                RoundButton(
                  title: 'LogIn',
                  color: CustomsColors.c3,
                  loading: loading,
                  onTap:(){
                    print("Width**************");
                    print(_width);
                    print("Height**************");
                    print(_height);
                    if(_formKey.currentState!.validate())
                    {
                      logIn();
                    }
                    setState(() {
                      favorite[0].name=email;
                      emailControlle.clear();
                      passwordControlle.clear();
                    });
                  },
                ),
                SizedBox(height: _height/45.6),
                // ------------- OR ---------- code
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
                SizedBox(height: 30/30.4),
                //Login with FaceBook
                Padding(
                  padding: const EdgeInsets.only(left: 65,right: 65),
                  child: TextButton(
                      onPressed:() {

                      },
                      child:Center(
                        child: Row(
                          children: [
                            Image.asset('assets/icon/facebook.png',width: 37,height: 28,color: CustomsColors.c3),
                            Text('Login With Facebook',style: TextStyle(
                              color: CustomsColors.c3,
                              fontSize: 17,
                              letterSpacing: 0.8,
                            ),),
                          ],
                        ),
                      )
                  ),
                ),
                SizedBox(height: _height/30.4),
                //Login With Phone Number
                InkWell(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>LoginWithPhoneNumber()));
                  },
                  child: Container(
                    width: 350,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: CustomsColors.c3,
                    ),
                    child: Center(child:Text('Login With Phone number',style: TextStyle(
                      color: CustomsColors.c14,
                      fontSize: 21,
                      letterSpacing: 1.0,
                      wordSpacing: 0.1,

                    ),)),
                  ),
                ),
                SizedBox(height:_height/5.3,),
                // Divider
                Divider(
                  color: CustomsColors.c10,
                  thickness: 1.3,
                ),
                // dont have account /signup
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have an accocunt?",style: TextStyle(color: CustomsColors.c6,fontSize: 19),),
                    TextButton(
                        onPressed:() {
                          Navigator.push(context,MaterialPageRoute(builder: (context)=>SignUpScreen()));
                        },
                        child:Center(
                          child:Text('SignUp',
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
