import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_with_flutter/handler/ErorrHandler.dart';
import 'package:firebase_with_flutter/screens/widgete/RoundButton.dart';
import 'package:firebase_with_flutter/utils/CustomsColors.dart';

import 'package:flutter/material.dart';

class RTDBAddNew extends StatefulWidget {
  const RTDBAddNew({Key? key}) : super(key: key);

  @override
  State<RTDBAddNew> createState() => _RTDBAddNewState();
}

class _RTDBAddNewState extends State<RTDBAddNew> {
  final textController=TextEditingController();
  bool loading=false;

  final databaseRef=FirebaseDatabase.instance.ref('AddNew');
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
              'Add Data',
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
            TextFormField(
              maxLines: 4,
              controller: textController,
              decoration: InputDecoration(
                hintText: 'Add Data For RealTime DB...',
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
                     databaseRef.child(id).set({
                       'id':id,
                       'title': textController.text.toString()})
                     .then((value)
                     {
                       ErorrHandler().toastMessage('AddNew Successfully');
                       setState(() {
                         loading=false;
                         textController.clear();
                       });
                     }
                     )
                     .onError((error, stackTrace){
                       ErorrHandler().toastMessage(error.toString());
                       setState(() {
                         loading=false;
                       });
                     });
                }
            ),
          ],
        ),
      ),
    );
  }
}
