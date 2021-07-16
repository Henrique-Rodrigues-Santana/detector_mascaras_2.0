import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

import 'main.dart';

class Home extends StatefulWidget {

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // definindo instancias
  CameraImage cameraImage ;
  CameraController cameraController;

  // definindo variáveis
  bool isWorking = false;
  String result = " ";

  initCamera(){
    // camera = define a camera traseira [0]
    // resoluctionPreset = a resolução da camera
    cameraController = CameraController(camera[0], ResolutionPreset.medium);
    // aqui , dentro do 'then' vamos avaliar se a camera está montada
    cameraController.initialize().then((value){
      if(!mounted){
        return;
      }

      setState(() {
        cameraController.startImageStream((imageFromStream) {
          if(!isWorking){
            isWorking = true;
            cameraImage = imageFromStream;
            runModelOnFrame();
          }
        });
      });
    });
  }

  runModelOnFrame()async{
    if(cameraImage != null){

      var recognitions = await Tflite.runModelOnFrame(
          bytesList: cameraImage.planes.map((plane)  {
            return plane.bytes;
          }).toList(),
          imageHeight: cameraImage.height,
          imageWidth: cameraImage.width,
          imageMean: 127.5,
          imageStd: 127.5,
          rotation: 90,
          numResults: 1,
          threshold: 0.1,
          asynch: true
      );

      result = " ";

      recognitions.forEach((response) {
        result += response["label"] + "\n";
      });

      setState(() {
        // result
      });

      isWorking = false;

    }
  }
  
  // carregando modelos tfLite
  loadModels()async{
    await Tflite.loadModel(
        model: "assets/model.tflite",
        labels: "assets/labels.txt");
  }

  @override
  void initState() {
    // TODO: implement setState
    super.initState();
    initCamera();
    loadModels();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber,
            title: result.isEmpty ? Text("Foque o rosto"):
                Padding(
                  padding: EdgeInsets.only(top: 30),
                  child: Text(result,
                    style: TextStyle(
                    fontSize: 25,),
                    textAlign: TextAlign.center,
                  ),),
            centerTitle: true,
          ),
          body: Container(
            child: (!cameraController.value.isInitialized)
                ? Container()
                : Align(
                alignment: Alignment.center,
                child: AspectRatio(
                  aspectRatio: cameraController.value.aspectRatio,
                  child: CameraPreview(
                    cameraController
                  ),
                ),
            )
                    ,
          ),
          backgroundColor: Colors.black,


        ),
      ),
    );
  }
}
