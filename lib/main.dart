import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';
import 'splash_screen.dart';
import 'splash_sreen2.dart';
import 'register_page.dart';
import 'login_page.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      initialRoute: '/',
      routes: {
        'register':(context)=>RegisterPage(),
        //'splash2':(context)=>SplashScreen2(),
        'login':(context)=>LoginPage(),
      },
    );
  }
}