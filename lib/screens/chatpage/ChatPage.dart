import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/FriendList.dart';
import '../../models/chatUsersModel.dart';
import '../../utils/CustomsColors.dart';
import 'conversation_list.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  List<ChatUsers> chatUsers = [
    ChatUsers(name: favorite[0].name, messageText: "Awesome Setup", imageURL: 'assets/friends/6.jpg' , time: "Now"),
    ChatUsers(name: favorite[1].name, messageText: "That's Great", imageURL:  'assets/friends/7.jpg' , time: "Yesterday"),
    ChatUsers(name:favorite[2].name, messageText: "Hey where are you?", imageURL: 'assets/friends/1.jpeg' , time: "31 Mar"),
    ChatUsers(name: favorite[3].name, messageText: "Busy! Call me in 20 mins", imageURL: 'assets/friends/2.jpg', time: "28 Mar"),
    ChatUsers(name: favorite[4].name, messageText: "Thankyou, It's awesome", imageURL:  'assets/friends/3.jpg', time: "23 Mar"),
    ChatUsers(name:favorite[5].name, messageText: "will update you in evening", imageURL:'assets/friends/4.jpg', time: "17 Mar"),
    ChatUsers(name:favorite[6].name, messageText: "Thankyou, It's awesome", imageURL:'assets/friends/5.jpg', time: "23 Mar"),

  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios,color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        backgroundColor: CustomsColors.c5,
        elevation: 0.3,
        title: Center(child: Text('FriendList',style: TextStyle(
            color: CustomsColors.c3,
            fontSize: 20,
            letterSpacing: 1.0
        ),),),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 16,left: 16,right: 16),
              child: TextField(
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
            ListView.builder(
              itemCount: chatUsers.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index){
                return ConversationList(
                  name: chatUsers[index].name,
                  messageText: chatUsers[index].messageText,
                  imageUrl: chatUsers[index].imageURL,
                  time: chatUsers[index].time,
                  isMessageRead: (index == 0 || index == 3)?true:false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
