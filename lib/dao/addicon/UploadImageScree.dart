
import 'dart:io';
import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../handler/ErrorHandler.dart';
import '../../screens/widgete/RoundButton.dart';
import '../../utils/CustomsColors.dart';

class UploadImageScree extends StatefulWidget {
  const UploadImageScree({Key? key}) : super(key: key);

  @override
  State<UploadImageScree> createState() => _UploadImageScreeState();
}

class _UploadImageScreeState extends State<UploadImageScree> {
  late bool loading=false;

  // late VideoPlayerController _videoGalleryController;
  // late VideoPlayerController _videoCameraController;


   File? _imageForGaller;
   // File? _imageForCamera;
   // File? _videoForGaller;
   // File? _videoForCamera;
  final picker= ImagePicker();


  // FireBase Storage

  // its Create image name in firebaseStorage EX. imageFolder(second).jpg
  final storageRef = FirebaseStorage.instance.ref('/imageFolder'+DateTime.now().millisecond.toString());

  // its Create ImageVideo Node in FirebaseDatabase
  DatabaseReference databaseRef=FirebaseDatabase.instance.ref('ImageVideo');

  // Get image from gallery
  Future getImageGallery()async{
    final pickedFile= await picker.pickImage(source: ImageSource.gallery,imageQuality: 80);
    setState(() {
      if(pickedFile !=null)
        {
          _imageForGaller=File(pickedFile.path);
        }
      else
        {
          print('NO Image Picked;');
          Text('No Image Picked.');
        }
    });
  }

  // Get image from Camera
  // Future getImageCamera()async{
  //   final pickedFile= await picker.pickImage(source: ImageSource.camera,imageQuality: 80);
  //   setState(() {
  //     if(pickedFile !=null)
  //     {
  //       _imageForCamera=File(pickedFile.path);
  //     }
  //     else
  //     {
  //       print('No Image Capture;');
  //       Text('No Image Capture.');
  //     }
  //   });
  // }

  // Get Video from Gallery
  // Future getVideoGallery()async{
  //   final pickedFile= await picker.pickVideo(source:ImageSource.gallery);
  //   setState(() {
  //     if(pickedFile !=null)
  //     {
  //       _videoForGaller=File(pickedFile.path);
  //       _videoGalleryController = VideoPlayerController.file(_videoForGaller!)..initialize().then((value){
  //         setState(() { });
  //         _videoGalleryController.play();
  //       });
  //     }
  //     else
  //     {
  //       print('No Video Uploaded from gallery');
  //       Text('No Video Uploaded from gallery');
  //     }
  //   });
  // }

  // Get Video from Camera
  // Future getVideoCamera()async{
  //   final pickedFile= await picker.pickVideo(source:ImageSource.camera);
  //   setState(() {
  //     if(pickedFile !=null)
  //     {
  //       _videoForCamera=File(pickedFile.path);
  //       _videoCameraController =VideoPlayerController.file(_videoForCamera!)..initialize().then((value){});
  //       setState(() {
  //         _videoCameraController.play();
  //       });
  //     }
  //     else
  //     {
  //       print('No Video Capture from Camera');
  //       Text('No Video Capture from Camera');
  //     }
  //   });
  // }


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
            'UploadImage',
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //Upload Image From Gallery
              SizedBox(height: 15,),
              InkWell(
                onTap: () {
                  getImageGallery();
                },
                child:Container(
                  width: 350,
                  height: 130,
                  decoration: BoxDecoration(
                    color: CustomsColors.c4.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child:_imageForGaller != null? Image.file(_imageForGaller!.absolute): Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: Stack(
                            children: [
                              Icon(Icons.image,color: CustomsColors.c5.withOpacity(0.6),size:60 ),
                              Padding(
                                padding: const EdgeInsets.only(left: 32),
                                child: Icon(Icons.add_box,color: CustomsColors.c3,size:30 ,),
                              ),

                            ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 20),
                        child: Text('Upload Image From Gallery',style: TextStyle(
                          color: CustomsColors.c3.withOpacity(0.6),
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          letterSpacing: 1.0,
                        ),),
                      )
                    ],
                  ) ,
                ),
              ),

              //Upload Image From Camera
              // SizedBox(height: 15,),
              // InkWell(
              //   onTap: () {
              //     getImageCamera();
              //   },
              //   child:_imageForCamera != null ? Image.file(_imageForCamera!.absolute):Container(
              //     width: 350,
              //     height: 130,
              //     decoration: BoxDecoration(
              //         color: CustomsColors.c4.withOpacity(0.7),
              //         borderRadius: BorderRadius.circular(20)
              //     ),
              //     child:Column(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(top: 15),
              //           child: Icon(Icons.add_a_photo_outlined,color: CustomsColors.c5.withOpacity(0.6),size:60 ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(top: 20),
              //           child: Text('Upload Image From Camera',style: TextStyle(
              //             color: CustomsColors.c3.withOpacity(0.6),
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20,
              //             letterSpacing: 1.0,
              //           ),),
              //         )
              //       ],
              //     ) ,
              //   ),
              // ),

              //Upload video From Gallery
              // SizedBox(height: 15,),
              // InkWell(
              //   onTap: () {
              //     getVideoGallery();
              //   },
              //   child:Container(
              //     width: 350,
              //     height: 130,
              //     decoration: BoxDecoration(
              //         color: CustomsColors.c4.withOpacity(0.7),
              //         borderRadius: BorderRadius.circular(20)
              //     ),
              //     child:_videoForGaller != null ? AspectRatio(
              //               aspectRatio: _videoGalleryController.value.aspectRatio,
              //               child: VideoPlayer(_videoGalleryController),
              //     ) :Column(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(top: 15),
              //           child: Icon(Icons.video_call_sharp,color: CustomsColors.c5.withOpacity(0.6),size:60 ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(top: 20),
              //           child: Text('Upload Video From Gallery',style: TextStyle(
              //             color: CustomsColors.c3.withOpacity(0.6),
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20,
              //             letterSpacing: 1.0,
              //           ),),
              //         )
              //       ],
              //     ) ,
              //   ),
              // ),

              //Upload video From Camera
              // SizedBox(height: 15,),
              // InkWell(
              //   onTap: () {
              //     getVideoCamera();
              //   },
              //   child:Container(
              //     width: 350,
              //     height: 130,
              //     decoration: BoxDecoration(
              //         color: CustomsColors.c4.withOpacity(0.7),
              //         borderRadius: BorderRadius.circular(20)
              //     ),
              //     child:_videoForCamera!=null ? AspectRatio(
              //       aspectRatio: _videoCameraController.value.aspectRatio,
              //       child: VideoPlayer(_videoCameraController),
              //     ) :Column(
              //       children: [
              //         Padding(
              //           padding: const EdgeInsets.only(top: 15),
              //           child: Icon(Icons.video_call_sharp,color: CustomsColors.c5.withOpacity(0.6),size:60 ),
              //         ),
              //         Padding(
              //           padding: const EdgeInsets.only(top: 20),
              //           child: Text('Upload Video From Camera',style: TextStyle(
              //             color: CustomsColors.c3.withOpacity(0.6),
              //             fontWeight: FontWeight.bold,
              //             fontSize: 20,
              //             letterSpacing: 1.0,
              //           ),),
              //         )
              //       ],
              //     ) ,
              //   ),
              // ),

              //Upload Button to submit
              SizedBox(height: 15,),
              RoundButton(
                color: CustomsColors.c3,
                title:'Upload',
                onTap: () async{
                  setState(() {

                    loading=true;
                  });
                  UploadTask imageGallery= storageRef.putFile(_imageForGaller!.absolute);
                  // UploadTask imageCamera= storageRef.putFile(_imageForCamera!.absolute);
                  // UploadTask videoGallery= storageRef.putFile(_videoForGaller!.absolute);
                  // UploadTask videoCamera= storageRef.putFile(_videoForCamera!.absolute);
                  // List<UploadTask> list=[imageCamera,imageGallery,videoGallery,videoCamera];

                  String id=DateTime.now().millisecond.toString();
                  // for(int i=0; i<list.length;i++)
                  //   {
                     // await Future.value(list[i]);
                      await Future.value(imageGallery);
                      //urlList.add(storageRef.getDownloadURL());
                      databaseRef.child(id).set({
                        'id':id,
                        'path': await storageRef.getDownloadURL()
                      }).then((value){
                        ErrorHandler().toastMessage("Image And Video Path Uploaded Successfully");
                        setState(() {
                          loading=false;
                        });
                      }).onError((error, stackTrace) {
                        ErrorHandler().toastMessage(error.toString());
                        setState(() {
                          loading=false;
                        });
                      });
                  //  }
                },
                loading: loading,
              )
            ],
          ),
        ),
      ),
    );
  }
}
