import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../models/FriendList.dart';

class FriendListWidget extends StatelessWidget {
  const FriendListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: favorite.length,
        itemBuilder: (BuildContext context,int index)  {
           return Column(
            children: [
           Padding(
            padding:EdgeInsets.only(left: 3),
            child: CircleAvatar(
                radius: 40,
                backgroundImage: AssetImage(favorite[index].image),
              ),
            ),
           SizedBox(
             width: 90,
             child: Align(
               alignment: Alignment.center,
               child: Text(
                  favorite[index].name,
                  style: TextStyle(
                      fontWeight: FontWeight.w400,
                      fontSize: 15,
                    //  letterSpacing: 1.0
                  ),
                ),
             ),
           ),
        ],
      );
    },
      ),
    );
  }
}
