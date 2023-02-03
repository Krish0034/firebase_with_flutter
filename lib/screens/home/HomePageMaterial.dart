import 'package:firebase_with_flutter/models/FriendList.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:pinch_zoom/pinch_zoom.dart';

import '../../models/UserItems.dart';
import '../../utils/CustomsColors.dart';


class HomePageMaterial extends StatelessWidget {

  bool isLiked =false;
  int count=0;
  int length=favorite.length;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: length,
        itemBuilder:(context, index) {
          return Container(
            width: MediaQuery.of(context).size.width,
            height:MediaQuery.of(context).size.height-350,
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(width: 5,),
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(favorite[index].image),
                    ),
                    SizedBox(width: 5,),
                    Container(
                      width: 90,
                      height: 30,
                      child: Text(favorite[index].name,style: TextStyle(
                      color: CustomsColors.c14,fontSize: 22,letterSpacing: 1.0)),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width/2,),
                    IconButton(
                        onPressed: () {
                        showModalBottomSheet(
                        shape: OutlineInputBorder(borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight:Radius.circular(20) )),
                        context: context,
                        builder: (BuildContext context)
                        {
                              return Column(
                                children: [
                                  SizedBox(height: 20,),
                                  Container(
                                    width: 30,height: 3,
                                    decoration: BoxDecoration(
                                      color: CustomsColors.c6.withOpacity(0.7),
                                      borderRadius: BorderRadius.circular(5)
                                    ),
                                  )
                                ],
                              );
                        }
                        );
                    },
                        icon: Icon(Icons.more_vert_sharp)
                    )
                  ],
                ),
                SizedBox(height: 5,),
                // Post Images
                Container(
                  height: 400,
                  width: MediaQuery.of(context).size.width,
                  child: PinchZoom(
                    resetDuration:Duration(seconds: 2),
                    onZoomEnd:(){},
                    maxScale: 2.2,
                    zoomEnabled: true,
                    child: Card(
                      shape: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(userItem[index].postImage),
                      ),
                    ),
                  ),
                  ),
                // Like Comment , and Send Button
                Row(
                  children: [
                    SizedBox(width: 10,),
                    // LikeButton
                    LikeButton(
                      size: 28,
                      // circleColor: CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      // bubblesColor: BubblesColor(
                      //   dotPrimaryColor: Color(0xff33b5e5),
                      //   dotSecondaryColor: Color(0xff0099cc),
                      // ),
                      isLiked:isLiked,
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          isLiked ? Icons.favorite: Icons.favorite_border,
                          color: isLiked ? Colors.red : null,
                          size: 28,
                        );
                      },
                      likeCount: count,
                      countBuilder: (count,isLiked,text) {
                        var color = isLiked ? Colors.deepPurpleAccent : Colors.grey;
                        Widget result;
                        if (count == 0) {
                          result = Text(
                            "love",
                            style: TextStyle(color: color),
                          );
                        } else
                          result = Text(
                            text,
                            style: TextStyle(color: color),
                          );
                        return result;
                      },
                    ),
                    SizedBox(width: 10,),
                    //CommentBox
                    IconButton(
                        onPressed: () {
                        },

                        icon: Icon(Icons.comment,size: 28,)
                    ),
                    SizedBox(width: 10,),
                    // Send Button
                    Center(
                      child: Transform.rotate(
                        angle: 5.7,
                        child: IconButton(
                            onPressed: () {
                            },
                            icon: Icon(Icons.send)
                        ),
                      ),
                    ),
                    SizedBox(width: 10,),
                  ],
                ),
              ],
            ),

          );
        },
      ),
    );
  }

}
