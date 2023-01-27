import 'package:firebase_with_flutter/services/splash_services.dart';
import 'package:firebase_with_flutter/utils/CustomsColors.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SplashServices splashServices=SplashServices();
  @override
  void initState()
  {
    super.initState();
    splashServices.isLogin(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height-165,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 250,),
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      color: CustomsColors.c3,
                      boxShadow:[ BoxShadow(
                          color:CustomsColors.c8 ,blurRadius:6 ,spreadRadius: 2.0
                      ),],
                      image: DecorationImage(
                          image: AssetImage("assets/images/splash_logo.png")
                      )
                  ),

                ),
                SizedBox(height: 180,),
                Text('from',style: TextStyle(
                    fontSize: 18,
                color:CustomsColors.c9.withOpacity(.3),
                ),),
                Image.asset('assets/icon/meta_icon.png',width: 120,height:50,)

                ]
            ),
          ),
        ),
      ),
      );

  }
}
