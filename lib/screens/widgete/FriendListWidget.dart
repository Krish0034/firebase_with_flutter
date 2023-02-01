import 'package:flutter/material.dart';
import '../../models/FriendList.dart';

class FriendListWidget extends StatelessWidget {
   Axis direction;
   int length;
   FriendListWidget(
       {
         Key? key,
         required this.direction,
         required this.length
       }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection:direction,
      itemCount: length,
      itemBuilder: (BuildContext context,int index)  {
         return Column(
          children: [
         Padding(
          padding:EdgeInsets.only(left: 3),
          child: CircleAvatar(
              radius: 36,
              backgroundImage: AssetImage(favorite[index].image),
            ),
          ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Text(
            favorite[index].name,
            style: TextStyle(
                letterSpacing: 0.8,
                fontSize: 18,
              //  letterSpacing: 1.0
            ),
            ),
         ),
      ],
    );
    },
    );
  }
}
