import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_with_flutter/handler/ErrorHandler.dart';
import 'package:firebase_with_flutter/screens/widgete/RoundButton.dart';
import 'package:firebase_with_flutter/utils/CustomsColors.dart';

import 'package:flutter/material.dart';

class FireStoreAddNew extends StatefulWidget {
  const FireStoreAddNew({Key? key}) : super(key: key);

  @override
  State<FireStoreAddNew> createState() => _FireStoreAddNewState();
}

class _FireStoreAddNewState extends State<FireStoreAddNew> {
  final textController=TextEditingController();
  bool loading=false;


  final fireStore=FirebaseFirestore.instance.collection('FireStoreData');
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
         backgroundColor:CustomsColors.c3,
          title: Center(
            child: Text(
              'AddNew FireStore',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  letterSpacing: .8,
                 // fontFamily: 'Calinea',
                  color: CustomsColors.c6
              ),
            ),
          ),
      ),
      backgroundColor: CustomsColors.c11,
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            SizedBox(height: 40,),

            // TextField where u can type
            TextFormField(
              maxLines: 4,
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Enter Data For FireStore...',
                filled: true,
                fillColor: CustomsColors.c3,
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 40,),
            RoundButton(
                loading: loading,
                title: 'Add',
                onTap: ()
                {
                  setState(() {
                    loading=true;
                  });
                  String id=DateTime.now().millisecond.toString();
                  fireStore.doc(id).set({
                    'title':textController.text.toString(),
                    'id': id,
                  })
                  .then((value) => {
                  setState(() {
                    loading=false;
                    textController.clear();
                  }),
                  ErrorHandler().toastMessage('Add Successfully...')
                  })
                  .onError((error, stackTrace) => {
                    setState(() {
                      loading=false;
                    }),
                    ErrorHandler().toastMessage(error.toString())
                  });

                }
            ),
          ],
        ),
      ),
    );
  }
}
