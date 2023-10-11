import 'package:appointment/accept_page.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'chat_page.dart';
class Homepage2 extends StatefulWidget {
  Homepage2({Key? key}) : super(key: key);
  @override
  State<Homepage2> createState() => _Homepage2State();
}
class _Homepage2State extends State<Homepage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(title: Text('Appointment'),
        centerTitle: true,),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 28,),
          CarouselSlider(
            items: [
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                      image: AssetImage("lib/assets/ict.jpg"),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage("lib/assets/first.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.all(6.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  image: DecorationImage(
                    image: AssetImage('lib/assets/tola12.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
            options: CarouselOptions(
              height: 150.0,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.8,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text("Students List ",style:TextStyle( fontSize: 30,fontWeight:
          FontWeight.bold,color: Colors.blue,)),
          SizedBox(height: 20,),
          Divider(color: Colors.black,),
          StreamBuilder(
            stream:
            FirebaseFirestore.instance.collection('students').snapshots(),
            builder: (context, snapshot) {
              List<Row> clientWidgets = [];
              if (snapshot.hasData) {
                final clients = snapshot.data?.docs.reversed.toList();
                for (var client in clients!) {
                  final clientWidget = Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: (){
                              Navigator.
                              of(context).push(MaterialPageRoute(
                                  builder: (ctx)=> AcceptPage(
                                    receiveUserName: client['name'],
                                    receiveUserId: client['uid'],
                                  )
                              )
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.all(13),
                              decoration: BoxDecoration(
                                color: Colors.indigo,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(
                                client['name'],
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            )
                        ),
                      ),
                    ],
                  );
                  clientWidgets.add(clientWidget);
                }
              }
              return Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: clientWidgets,
                  ),
                ),
              );
            },
          ),
          Divider(color: Colors.black,)
        ],
      ),
    );
  }
}
