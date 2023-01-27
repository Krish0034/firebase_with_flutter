import 'package:firebase_with_flutter/models/FriendList.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';

import '../../models/UserItems.dart';
import '../../utils/CustomsColors.dart';


class HomePageMaterial extends StatefulWidget {
  const HomePageMaterial({Key? key}) : super(key: key);

  @override
  State<HomePageMaterial> createState() => _HomePageMaterialState();
}

class _HomePageMaterialState extends State<HomePageMaterial> {
  bool isLiked =false;
  int count=0;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: userItem.length,
      itemBuilder:(context, index) {
        return  Container(
          width: MediaQuery.of(context).size.width,
          height:500,
          color: CustomsColors.c3,
          child: Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding:EdgeInsets.only(left: 3),
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(favorite[index].image),
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text(favorite[index].name,style: TextStyle(
                      color: CustomsColors.c14,fontSize: 22,letterSpacing: 1.0)),
                  Padding(
                    padding: const EdgeInsets.only(left: 220),
                    child: IconButton(
                        onPressed: () {},
                        icon:Icon(Icons.more_horiz_outlined,color: CustomsColors.c6.withOpacity(0.6),size: 25,)
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5,),
              Container(
                height: 380,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    border: Border.all(),
                    image: DecorationImage(
                      image: AssetImage(userItem[1].postImage),
                      fit:BoxFit.fill,
                    )
                ),
              ),
              Row(
                children: [
                  SizedBox(width: 10,),
                  // LikeButton
                  LikeButton(
                    size: 25,
                    circleColor: CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                    bubblesColor: BubblesColor(
                      dotPrimaryColor: Color(0xff33b5e5),
                      dotSecondaryColor: Color(0xff0099cc),
                    ),
                    isLiked:isLiked,
                    likeBuilder: (bool isLiked) {
                      return Icon(
                        isLiked ? Icons.favorite: Icons.favorite_border,
                        color: isLiked ? Colors.red : null,
                        size: 25,
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
                      icon: Icon(Icons.comment)
                  ),
                  SizedBox(width: 10,),
                  // Send Button
                  Transform.rotate(
                    angle: 100,
                    child: Center(
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
    );
  }
}
