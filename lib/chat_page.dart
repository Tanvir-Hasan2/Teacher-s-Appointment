import 'package:appointment/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
class ChatPage extends StatefulWidget {
  var receiveUserName;
  var receiveUserId;
  ChatPage({this.receiveUserId, this.receiveUserName});
  @override
  State<ChatPage> createState() => _ChatPageState();
}
class _ChatPageState extends State<ChatPage> {
  TextEditingController messageController = TextEditingController();
  ChatService chatService = ChatService();
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatService.sendMessage(
          widget.receiveUserId, messageController.text);
      messageController.clear();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiveUserName),
      ),
      body: Column(
        children: [
          Expanded(
            child: buildMessageList(),
          ),
          SizedBox(height: 10,),
          buildMessageInput(),
        ],
      ),
    );
  }

  Widget buildMessageList(){
    return StreamBuilder(
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Text('Error${snapshot.error}');
        }
        if(snapshot.connectionState == ConnectionState.waiting){
          return SpinKitCircle(
            color: Colors.blue,
            size: 50,
          );
        }
        return ListView(
          children: snapshot.data!.docs.map((document) =>
              buildMessageItem(document)).toList(),
        );
      },
      stream: chatService.getMessages(
          widget.receiveUserId, firebaseAuth.currentUser!.uid),

    );
  }
  Widget buildMessageItem(DocumentSnapshot document){
    Map<String, dynamic> data = document.data() as Map<String,
        dynamic>;
    var alignment = (data['sendId'] == firebaseAuth.currentUser!.uid)
        ? Alignment.centerRight
        : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Container(
        alignment: alignment,
        width: 200,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(data['sendName'],style: TextStyle(fontWeight:
              FontWeight.bold,fontSize: 19,),),
              Text(data['message'],style: TextStyle(fontSize: 17),),
              SizedBox(height: 6,),
            ],
          ),
        ),
      ),
    );
  }
  Widget buildMessageInput(){
    return Row(
      children: [
        Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.grey[200],
              ),
              child: TextFormField(
                controller: messageController,
                decoration: InputDecoration(
                  hintText: 'Enter your message...',
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  border: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            )
        ),
        SizedBox(width: 5,),
        ElevatedButton(
          onPressed: sendMessage,
          child: Text("send"),),
      ],
    );
  }
}
