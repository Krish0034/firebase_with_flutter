
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_with_flutter/handler/ErrorHandler.dart';
import 'package:flutter/material.dart';

import '../../utils/CustomsColors.dart';

class FetchDataFormRTDB extends StatefulWidget {
  const FetchDataFormRTDB({Key? key}) : super(key: key);

  @override
  State<FetchDataFormRTDB> createState() => _FetchDataFormRTDBState();
}

class _FetchDataFormRTDBState extends State<FetchDataFormRTDB> with TickerProviderStateMixin{

  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref('AddNew');
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
            'FetchDataFormRTDB',
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
          // Expanded(
          //   child: StreamBuilder(
          //     stream: ref.onValue,
          //     builder: (context,AsyncSnapshot<DatabaseEvent> snapshot)
          //     {
          //       if(!snapshot.hasData)
          //         {
          //           return Center(
          //             child: CircularProgressIndicator(
          //               color: CustomsColors.c11,
          //               backgroundColor: CustomsColors.c3,
          //               strokeWidth: 5,
          //             ),
          //           );
          //         }
          //       else
          //         {
          //           Map<dynamic,dynamic> map= snapshot.data!.snapshot.value as dynamic;
          //           List<dynamic> list =[];
          //           list.clear();
          //           list=map.values.toList();
          //           return ListView.builder(
          //
          //               itemCount: snapshot.data!.snapshot.children.length ,
          //               itemBuilder:(context, index) {
          //                 return ListTile(
          //                   title: Text(list[index]['title']),
          //                   subtitle: Text(list[index]['id']),
          //                 );
          //             },
          //           );
          //         }
          //     },
          //
          //   )
          // ),
          // Retrive Data From FireBaseDataBase with the help of FirebaseAnimatedList
          Expanded(
            child: FirebaseAnimatedList(
                query:ref,
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
                  final title=snapshot.child('title').value.toString();
                  final id=snapshot.child('id').value.toString();
                  if(searchFilter.text.isEmpty)
                  {
                    return ListTile(
                      title:Text('Title: ' + snapshot.child('title').value.toString(),
                        style: TextStyle(
                          color: CustomsColors.c15,
                          // fontSize: 20
                        ),),
                      subtitle:Text('Id: ' + id,
                        style: TextStyle(
                          color: CustomsColors.c15,
                          // fontSize: 20
                        ),),
                      trailing: PopupMenuButton(
                        icon: Icon(Icons.more_vert_sharp),
                        itemBuilder: (context)=>[

                          //Update or Edit
                          PopupMenuItem(
                            value:1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                showMyDialogue(title,id);
                              },
                              leading: Icon(Icons.edit),
                              title: Text('Edit'),
                            ) ,
                          ),

                          // Delete
                          PopupMenuItem(
                            value:1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                ref.child(snapshot.child('id').value.toString()).remove()
                                .then((value){
                                  ErrorHandler().toastMessage('Deleted Successfully.');
                                }).onError((error, stackTrace){
                                  ErrorHandler().toastMessage(error.toString());
                                });
                              },
                              leading: Icon(Icons.delete),
                              title: Text('Delete'),
                            ) ,
                          ),

                        ],
                      ),
                    );
                  }
                  else if(title.toLowerCase().contains(searchFilter.text.toLowerCase().toString()))
                  {
                    return ListTile(
                      title: Text(
                        'Title: ' + snapshot.child('title').value.toString(),
                        style: TextStyle(
                          color: CustomsColors.c15,
                          // fontSize: 20
                        ),
                      ),
                      subtitle: Text(
                        'Id: ' + snapshot.child('id').value.toString(),
                        style: TextStyle(
                          color: CustomsColors.c15,
                          // fontSize: 20
                        ),
                      ),
                    );
                  }
                  else
                  {
                    return Container();
                  }

                }
            ),
          )

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
                  ref.child(id).update(
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
