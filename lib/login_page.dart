import 'package:appointment/splash_sreen2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);
  @override
  State<LoginPage> createState() => _LoginPageState();
}
class _LoginPageState extends State<LoginPage> {
  String selectedItem = 'Student';
  List options = ['Teacher', 'Student'];
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool passToggle = true;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User?user;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Login "),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(image: AssetImage('lib/assets/login.jpeg',), width: 150,),
              SizedBox(height: 25,),
              DropdownButton(
                value: selectedItem,
                items: options
                    .map(
                      (day) =>
                      DropdownMenuItem(
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
              Container(
                padding: EdgeInsets.all(6),
                child: Column(
                  children: [
                    SizedBox(height: 8,),
                    TextFormField(
                      controller: emailController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                          label: Text("Email"),
                          hintText: 'Enter Email',
                          prefixIcon: Icon(Icons.email),
                          contentPadding:
                          EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                25.0)),
                          )
                      ),
                    ),
                    SizedBox(height: 8.0,),
                    TextField(
                      controller: passwordController,
                      textAlign: TextAlign.center,
                      obscureText: passToggle,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          suffixIcon: InkWell(
                            onTap: () {
                              setState(() {
                                passToggle = !passToggle;
                              });
                            },
                            child:
                            Icon(passToggle ? Icons.visibility : Icons
                                .visibility_off),
                          ),
                          label: Text("Password"),
                          hintText: "Enter Password",
                          contentPadding: EdgeInsets.symmetric(vertical:
                          10.0, horizontal: 20.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(
                                32.0)),
                          )
                      ),
                    ),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.symmetric(vertical: 15.0),
                child: Material(
                  elevation: 5.0,
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(30.0),
                  child: MaterialButton(
                    onPressed: () async {
                      if (selectedItem == 'Teacher') {
                        bool email = false;
                        bool pass = false;
                        var collectionReference =
                        FirebaseFirestore.instance.collection('teachers');
                        QuerySnapshot querySnapshot = await
                        collectionReference.get();
                        querySnapshot.docs.forEach((doc) async {
                          var Email = doc.get('email');
                          var Pass = doc.get('pass');
                          if (Email == emailController.text &&
                              Pass == passwordController.text) {
                            email = true;
                            pass = true;
                            UserCredential userCredential = await
                            auth.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text
                            );
                            Navigator.of(context).push(
                                MaterialPageRoute(builder:
                                    (ctx) => SplashScreen2(selectedItem)));
                            Fluttertoast.showToast(
                                msg: "Succesfull Logged in",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 18.0
                            );
                          }
                        });
                        if (email == false || pass == false) {
                          Fluttertoast.showToast(
                              msg: "Wrong Email or Password ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 18.0
                          );
                        }
                      }
                      if (selectedItem == 'Student') {
                        bool email = false;
                        bool pass = false;
                        var collectionReference =
                        FirebaseFirestore.instance.collection('students');
                        QuerySnapshot querySnapshot = await
                        collectionReference.get();
                        querySnapshot.docs.forEach((doc) async {
                          var Email = doc.get('email');
                          var Pass = doc.get('pass');
                          if (Email == emailController.text &&
                              Pass == passwordController.text) {
                            email = true;
                            pass = true;
                            UserCredential userCredential = await
                            auth.signInWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text
                            );
                            Navigator.of(context).push(
                                MaterialPageRoute(builder:
                                    (ctx) => SplashScreen2(selectedItem)));
                            Fluttertoast.showToast(
                                msg: "Succesfull Logged in",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.BOTTOM,
                                backgroundColor: Colors.blue,
                                textColor: Colors.white,
                                fontSize: 18.0
                            );
                          }
                        });
                        if (email == false || pass == false) {
                          Fluttertoast.showToast(
                              msg: "Wrong Email or Password ",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              backgroundColor: Colors.redAccent,
                              textColor: Colors.white,
                              fontSize: 18.0
                          );
                        }
                      }
                      /* try{
 UserCredential userCredential = await
auth.signInWithEmailAndPassword(
 email: emailController.text,
 password: passwordController.text
 );
 user = userCredential.user;
 if(user!=null){
 // Navigator.pushNamed(context,"splash2");
 Navigator.of(context).push(MaterialPageRoute(builder:
(ctx)=>SplashScreen2(selectedItem)));
 Fluttertoast.showToast(
 msg: "Succesfull Logged in",
 toastLength: Toast.LENGTH_SHORT,
 gravity: ToastGravity.BOTTOM,
 backgroundColor: Colors.blue,
 textColor: Colors.white,
 fontSize: 18.0
 );
 }
 }
 on FirebaseAuthException catch(e){
 if(e.code=='user-not-found'){
 //
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
Text('no user oound'),backgroundColor: Colors.red,));
 Fluttertoast.showToast(
 msg: "wrong email or password",
 toastLength: Toast.LENGTH_SHORT,
 gravity: ToastGravity.CENTER_LEFT,
 backgroundColor: Colors.red,
 textColor: Colors.white,
 fontSize: 16.0
 );
 }
 if(e.code=='wrong-password'){
 //
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content:
Text('no match pass ound'),backgroundColor: Colors.red,));
 Fluttertoast.showToast(
 msg: "wrong email or password",
 toastLength: Toast.LENGTH_SHORT,
 gravity: ToastGravity.CENTER_LEFT,
 backgroundColor: Colors.red,
 textColor: Colors.white,
 fontSize: 16.0
 );
 }
 }
 catch(e){
 print(e);
 } */
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: Text("Sign In", style: TextStyle(
                      color: Colors.white,
                    ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 6.0,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  InkWell(
                    child: Text("Register now"
                      , style: TextStyle(
                          color: Colors.blue
                      ),
                    ),
                    onTap: () {
                      Navigator.pushNamed(context, "register");
                    },
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}