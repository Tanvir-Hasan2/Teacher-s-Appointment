import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class AcceptPage extends StatefulWidget {
  var receiveUserName;
  var receiveUserId;
  AcceptPage({this.receiveUserId, this.receiveUserName});
  @override
  State<AcceptPage> createState() => _AcceptPageState();
}
class _AcceptPageState extends State<AcceptPage> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.receiveUserName),),
      body: StreamBuilder(
        builder: (context, snapshot) {
          final userData = snapshot.data!.data() as Map<String, dynamic>;
          return ListView(
            children: [
              Text(userData['msg']),
            ],
          );
        },
        stream:
        FirebaseFirestore.instance.collection('records').doc(widget.receiveUserI
            d).snapshots(),
      ),
    );
  }
}