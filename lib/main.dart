import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

import 'SplashScreen.dart';

List<CameraDescription> camera ;



Future<void>main() async{
 // verificar cameras disponiveis
  WidgetsFlutterBinding.ensureInitialized();
  camera = await availableCameras();

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: SS(),
  ));
}