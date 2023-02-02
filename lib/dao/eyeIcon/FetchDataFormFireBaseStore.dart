
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_with_flutter/handler/ErrorHandler.dart';
import 'package:flutter/material.dart';

import '../../utils/CustomsColors.dart';

class FetchDataFormFireBaseStore extends StatefulWidget {
  const FetchDataFormFireBaseStore({Key? key}) : super(key: key);

  @override
  State<FetchDataFormFireBaseStore> createState() => _FetchDataFormFireBaseStoreState();
}

class _FetchDataFormFireBaseStoreState extends State<FetchDataFormFireBaseStore> with TickerProviderStateMixin{

  final auth = FirebaseAuth.instance;
  final fireStore=FirebaseFirestore.instance.collection('FireStoreData').snapshots();
  CollectionReference ref=FirebaseFirestore.instance.collection('FireStoreData');

  // user id which pass by user


  late AnimationController circularController;
  final searchFilter = TextEditingController();
  final editController = TextEditingController();
  @override
  void initState() {
    circularController = AnimationController(
      /// [AnimationController]s can be created with `vsync: this` because of
      /// [TickerProviderStateMixin].
      vsync: this,
      duration: const Duration(seconds: 2),
    )..addListener(() {
      setState(() {

      });
    });
    circularController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    circularController.dispose();
    super.dispose();
  }
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
            'FetchDataFormFireStore',
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

          // Search OR Filtter data from Firebase DB
          Padding(
            padding: EdgeInsets.only(top: 16,left: 16,right: 16),
            child: TextField(
              controller: searchFilter,
              onChanged: (value) {
                setState(() {

                });
              },
              decoration: InputDecoration(
                hintText: "Search...",
                hintStyle: TextStyle(color: Colors.grey.shade600),
                prefixIcon: Icon(Icons.search,color: Colors.grey.shade600, size: 20,),
                filled: true,
                fillColor: CustomsColors.c11.withOpacity(0.4),
                contentPadding: EdgeInsets.all(8),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28),
                    borderSide: BorderSide(
                        color: CustomsColors.c11
                    )
                ),
              ),
            ),
          ),
          /// We are Retrieve Data From Firebase DB with the help of Two
          /// Method ***< 1.>Using of StreamBuilder and
          /// Method ***< 2.>Using of FirebaseAnimatedList
          // Retrive Data From FireBaseDataBase with the help of StreamBuilder
          Expanded(
            child: StreamBuilder(
              stream: fireStore,
              builder:(BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot) {

                // circualr indicator that's means waiting
                if(snapshot.connectionState== ConnectionState.waiting)
                {
                  return Center(
                    child: CircularProgressIndicator(
                      color: CustomsColors.c11,
                      backgroundColor: CustomsColors.c3,
                      strokeWidth: 5,
                    ),
                  );
                }
                // this is give us error
                if(snapshot.hasError)
                {
                  return Text('Some Error...');
                }
                else
                {
                   return ListView.builder(
                       itemCount: snapshot.data!.docs.length,
                       itemBuilder: (context,index)
                       {
                         String title=snapshot.data!.docs[index]['title'].toString();
                         String id=snapshot.data!.docs[index]['id'].toString();

                         // show data which store on firebasefirestore db
                         if(searchFilter.text.isEmpty)
                           {
                             return ListTile(
                               title: Text(title),
                               subtitle: Text(id),

                               // edit icon where u can update data and deleted
                               trailing: PopupMenuButton(
                                 icon: Icon(Icons.more_vert_sharp),
                                 itemBuilder: (context)=>[

                                   //updated code
                                   PopupMenuItem(
                                       child: ListTile(
                                         onTap: (){
                                           Navigator.pop(context);
                                           showMyDialogue(title,id);
                                         },
                                         leading: Icon(Icons.edit),
                                         title: Text('Edit'),
                                       )
                                   ),

                                   // deleted code
                                   PopupMenuItem(
                                       child: ListTile(
                                         onTap: (){
                                           Navigator.pop(context);
                                           ref.doc(id).delete().then((value){
                                             ErrorHandler().toastMessage('Deleted Successfully');
                                           }).onError((error, stackTrace){
                                             ErrorHandler().toastMessage(error.toString());
                                           });
                                         },
                                         leading: Icon(Icons.delete),
                                         title: Text('Delete'),
                                       )
                                   ),
                                 ],
                               ),
                             );
                           }
                         else if(title.toLowerCase().contains(searchFilter.text.toLowerCase().toString()))
                           {
                             return ListTile(
                               title: Text(snapshot.data!.docs[index]['title'].toString()),
                               subtitle: Text(snapshot.data!.docs[index]['id'].toString()),
                             );
                           }
                         else
                           {
                             return Container();
                           }

                       }
                   );
                 }

              },

            )
          ),
          /// /future builder use to access user by id
         //  Expanded(
         //     child:FutureBuilder(
         //
         //       future: ref.doc('203').get(),
         //       builder: (BuildContext context,AsyncSnapshot<DocumentSnapshot> snapshot){
         //         if(snapshot.hasError)
         //         {
         //           return Text('Some Error...');
         //         }
         //         else if(snapshot.hasData && !snapshot.data!.exists)
         //           {
         //             return Text("Document does not exist");
         //           }
         //         else if (snapshot.connectionState == ConnectionState.done) {
         //           Map<String, dynamic> map = snapshot.data!.data() as Map<String, dynamic>;
         //           List<dynamic> list=[];
         //           list.clear();
         //           list=map.values.toList();
         //           return ListTile(
         //             title: Text(list.toString()),
         //             subtitle: Text("id"),
         //           );
         //         }
         //         else
         //           {
         //             return Container();
         //           }
         //
         //       },
         //     ),
         // ),

        ],
      ),
    );

  }

  /// Edit Dialog Box and this is Update code with firebase
  Future<void> showMyDialogue(String title,String id) async{
    editController.text=title;
    return showDialog(

        context: context,
        builder:(BuildContext context)
        {
          return AlertDialog(
            title: Text('Update'),
            content:Container(
              child: TextFormField(
                maxLines: 4,
                controller: editController,
                decoration: InputDecoration(
                    hintText: 'edit...'
                ),

              ),
            ),
            actions: [
              // cencel button
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child:Text('Cencel',style: TextStyle(
                      color: CustomsColors.c7
                  ),)
              ),

              //Update Button
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref.doc(id).update(
                      {
                        'title': editController.text.toString()
                      }).then((value){
                    ErrorHandler().toastMessage('Update Successfully');
                  }).onError((error, stackTrace){
                    ErrorHandler().toastMessage(error.toString());
                  });

                },
                child:Text('Update',style: TextStyle(color: CustomsColors.c7)),
              ),
            ],
          );
        }
    );

  }
}
