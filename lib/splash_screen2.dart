import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'home_page.dart';
import 'home_page2.dart';
class SplashScreen2 extends StatefulWidget {
  var selectedItem;
  SplashScreen2(this.selectedItem);
  @override
  State<SplashScreen2> createState() =>
      _SplashScreenState2(selectedItem);
}
class _SplashScreenState2 extends State<SplashScreen2> {
  var selectedItem;

  _SplashScreenState2(this.selectedItem);

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (selectedItem == 'Student') {
      Future.delayed(Duration(seconds: 3)).then((value) =>
      {Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => HomePage()))
      });
    }
    else if (selectedItem == 'Teacher') {
      Future.delayed(Duration(seconds: 3)).then((value) =>
      {Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx) => Homepage2()))
      });
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image(image: AssetImage('lib/assets/splash.jpeg'),
              width: 300,
            ),
            SizedBox(height: 50,),
            Text(' Loading..', style: TextStyle(fontSize: 20),),
            SizedBox(height: 20,),
            SpinKitPouringHourGlass(
              color: Colors.blue,
              size: 50,
            ),
            SizedBox(height: 160,),
            const Text('\n\n© Tech Group. All Rights Reserved.', style:
            TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color:
            Colors.black)),
            const Text('\nDeveloped By: Tech Titans', style:
            TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color:
            Colors.deepPurple)),
          ],
        ),
      ),
    );
  }
}