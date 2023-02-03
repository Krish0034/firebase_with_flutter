import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_with_flutter/handler/ErrorHandler.dart';
import 'package:firebase_with_flutter/screens/authenticate/login_screen.dart';
import 'package:firebase_with_flutter/utils/CustomsColors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import '../../dao/addicon/FireStoreAddNew.dart';
import '../../dao/addicon/UploadImageScree.dart';
import '../../dao/eyeIcon/FetchDataFormFireBaseStore.dart';
import '../../dao/eyeIcon/FetchDataFormRTDB.dart';
import '../../dao/eyeIcon/ShowImage.dart';
import '../../models/FriendList.dart';
import '../../dao/addicon/RTDBAddNew.dart';
import '../chatpage/ChatPage.dart';
import '../widgete/FriendListWidget.dart';
import 'HomePageMaterial.dart';

class InstaHomePage extends StatefulWidget {
//  String name;

  InstaHomePage({Key? key}) : super(key: key);

  @override
  State<InstaHomePage> createState() => _InstaHomePageState();
}


class _InstaHomePageState extends State<InstaHomePage> {

 FirebaseAuth auth=FirebaseAuth.instance;
  bool isLiked =false;
  int likeCount=0;
  int length=favorite.length;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(180),
        child: Column(
          children: [
            AppBar(
              // toolbarHeight:,
              automaticallyImplyLeading: false,
              backgroundColor: CustomsColors.c3,
              title:Text('Instagram',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 38,
                  letterSpacing: .8,
                  fontFamily: 'Calinea',
                  color: CustomsColors.c6
                ),

              ),
              elevation: 0.0,
              actions: [
                //home page AddIcon
                PopupMenuButton(
                  icon: Icon(
                    Icons.add_box,
                    size: 30.0,
                    color: CustomsColors.c6.withOpacity(0.7),
                  ),
                 itemBuilder:(context) => [
                   //PopmenuIcon for RealTime DataBase
                   PopupMenuItem(
                     child:ListTile(
                       onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> RTDBAddNew()));
                       },
                       leading: Icon(MdiIcons.databaseArrowRight),
                       title: Text('RealTimeDB'),
                     ),
                     value: 1,
                   ),

                   // PopmenuIcon for FireStore DataBase
                   PopupMenuItem(
                       child:ListTile(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> FireStoreAddNew()));
                         },
                         leading: Icon(MdiIcons.cloudUpload),
                         title: Text('FireStoreDB'),
                       ),
                     value:2 ,
                   ),

                   // PopmenuIcon for Upload Image
                   PopupMenuItem(
                       child:ListTile(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> UploadImageScree()));
                         },
                         leading: Icon(Icons.image),
                         title: Text('UploadImage'),
                       ),
                     value:2 ,
                   ),
                 ],
                ),

                //Home page eyes icon
                PopupMenuButton(
                  icon: Icon(
                    Icons.remove_red_eye,
                    size: 30.0,
                    color: CustomsColors.c6.withOpacity(0.7),
                  ),
                 itemBuilder:(context) => [
                   PopupMenuItem(
                     child:ListTile(
                       onTap: () {
                         Navigator.push(context, MaterialPageRoute(builder: (context)=> FetchDataFormRTDB()));
                       },
                       leading: Icon(MdiIcons.databaseArrowRight),
                       title: Text('RealTimeDB'),
                     ),
                     value: 1,
                   ),
                   PopupMenuItem(
                       child:ListTile(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> FetchDataFormFireBaseStore()));
                         },
                         leading: Icon(MdiIcons.cloudUpload),
                         title: Text('FireStoreDB'),
                       ),
                     value:2 ,
                   ),
                   PopupMenuItem(
                       child:ListTile(
                         onTap: () {
                           Navigator.push(context, MaterialPageRoute(builder: (context)=> ShowImage()));
                         },
                         leading: Icon(MdiIcons.download),
                         title: Text('ImageDownload'),
                       ),
                     value:2 ,
                   ),
                 ],
                ),

                // Home Page chatIcon
                IconButton(
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> ChatPage()));
                    },
                    icon:  Icon(
                      Icons.send,
                      size: 30.0,
                      color: CustomsColors.c6.withOpacity(0.7),
                    ),
                ),
                // Home Page LogoutIcon
                IconButton(
                      onPressed:() {
                    auth.signOut().then((value){
                      Navigator.push(context,MaterialPageRoute(builder: (context)=>LoginScreen()));
                    }).onError((error, stackTrace){
                      ErrorHandler().toastMessage(error.toString());
                    });
                  },
                  icon:Icon(
                    Icons.logout,
                    size: 30.0,
                    color: CustomsColors.c6.withOpacity(0.7),
                  ),
                ),
              ]),

            // FriendList CircularAvtar with story
            Container(
                height: 120,
                child: FriendListWidget(direction:Axis.horizontal,length:length,)
            ),
          ],
        ),
      ),
      backgroundColor: CustomsColors.c3,
      body: ListView(
       // mainAxisAlignment: MainAxisAlignment.start,
        shrinkWrap: true,
        children: [
          // Home Page Post Imagese
          Container(
              height: MediaQuery.of(context).size.height-200,
              child: HomePageMaterial()
         ),
        ],
      )
    );
  }
  // Widget countBuilder(int likeCount,bool isLiked,Text text)
  // {
  //   final color = CustomsColors.red:
  // }
}
