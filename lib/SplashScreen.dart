import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';

import 'HomePage.dart';

class SS extends StatefulWidget {
  @override
  _SSState createState() => _SSState();
}

class _SSState extends State<SS> {
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 5,
      navigateAfterSeconds: Home(),
      title: Text("Leitor de Mascaras",style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 20,
        color: Colors.black
      ),
      ),
      image: Image.asset("assets/img.jpg"),
      photoSize: 170,
      backgroundColor: Colors.white,
      loaderColor: Colors.amber,
      loadingText: Text("by Henrique Rodrigues",style: TextStyle(
        color: Colors.black,
        fontSize: 16
      ),
        textAlign: TextAlign.center,
      ),


    );
  }
}
