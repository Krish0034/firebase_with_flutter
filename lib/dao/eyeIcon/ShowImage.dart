import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../../utils/CustomsColors.dart';

class ShowImage extends StatefulWidget {
  const ShowImage({Key? key}) : super(key: key);

  @override
  State<ShowImage> createState() => _ShowImageState();
}

class _ShowImageState extends State<ShowImage> {
 // final storageRef = FirebaseStorage.instance.ref('/imageFolder'+DateTime.now().millisecond.toString());
  DatabaseReference databaseRef=FirebaseDatabase.instance.ref('ImageVideo');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: CustomsColors.c3,
        title: Center(
          child: Text(
            'DownloadImage',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
                letterSpacing: .8,
                // fontFamily: 'Calinea',
                color: CustomsColors.c6
            ),
          ),
        ),
      ) ,
      body: Column(
        children: [
          Expanded(
            child: FirebaseAnimatedList(
                query:databaseRef,
                // circular indicator..
                defaultChild: Center(
                  child: CircularProgressIndicator(
                    color: CustomsColors.c11,
                    backgroundColor: CustomsColors.c3,
                    strokeWidth: 5,
                  ),
                ),
                itemBuilder:(context,snapshot,animation,index)
                {
                  return Image.network(snapshot.child('path')!.value.toString());
                }
            ),
          )
        ],
      ),

    );
  }
}
