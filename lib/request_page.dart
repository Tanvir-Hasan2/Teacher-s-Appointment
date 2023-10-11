import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class RequestPage extends StatefulWidget {
  var receiveUserName;
  var receiveUserId;
  RequestPage({this.receiveUserId, this.receiveUserName});
  @override
  State<RequestPage> createState() => _RequestPageState();
}
class _RequestPageState extends State<RequestPage> {
  String selectedItem = 'Project';
  List options = ['Project', 'Thesis','Assignment'];
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  TimeOfDay time=TimeOfDay(hour: 0, minute: 0);
  DateTime date=DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(widget.receiveUserName),),
        body: SingleChildScrollView(
            child: Column(
                children: [

                Text(date.day.toString()+"/"+date.month.toString()+"/"+date.year.toStri
            ng()),
    IconButton(
    onPressed: (){
    showDatePicker(
    context: context,
    initialDate: DateTime.now(),
    firstDate: DateTime(2023),
    lastDate: DateTime(2100)).then((value) {
    setState(() {
    date = value!;
    });
    });
    },
    icon: Icon(Icons.date_range,size: 40,),),
    Text(time.format(context).toString()),
    IconButton(
    onPressed: (){
    showTimePicker(context: context, initialTime:
    TimeOfDay.now()).then((value) {
    setState(() {
    time = value!;
    });
    });
    },
    icon: Icon(Icons.access_time_filled,size: 40,)),
    Text('Reasons :'),
    DropdownButton(
    value: selectedItem,
    items: options
        .map(
    (day) => DropdownMenuItem(
    child: Text(day),
    value: day,
    ),
    )
        .toList(),
    onChanged: (value) {
    setState(() {
    selectedItem = value.toString();
    });
    },
    ),
    ElevatedButton(
    onPressed: (){
    firestore.collection('records').doc(auth.currentUser!.uid).set(
    {
    'time' : time.format(context).toString(),
    'date' :
    date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString(),
    'reason' : selectedItem.toString(),
    'msg' :"I would like to meet you "

    +date.day.toString()+"/"+date.month.toString()+"/"+date.year.toString()
    +" at "
    +time.format(context).toString()+' for ' +
    selectedItem.toString()
    }
    );
    },
    child: Text("Submit"))
    ],
    ),
    ),
    );
  }
}