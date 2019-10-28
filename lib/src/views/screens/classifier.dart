import 'dart:io';
import 'dart:async';
import 'package:justcook/src/views/screens/Receipe.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:justcook/src/constants/customColor.dart';
import 'package:tflite/tflite.dart';
import 'package:toast/toast.dart';

class RecognitionResult {
  double confidence;
  int index;
  String label;
}

class ClassifierScreen extends StatefulWidget {
  @override
  _ClassifierScreenState createState() => _ClassifierScreenState();
}

class _ClassifierScreenState extends State<ClassifierScreen> {
  List<CameraDescription> cameras;
  CameraController controller;
  String imagePath;
  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  void initTensorflow() async {
    String res = await Tflite.loadModel(
        model: "assets/optimized_graph.lite",
        labels: "assets/retrained_labels.txt",
        numThreads: 1 // defaults to 1
        );

    print(
        "====================================================================================");
    print(res);
    print(
        "====================================================================================");
  }

  void recognize(String filePath) async {
    var recognitions = await Tflite.runModelOnImage(
        path: filePath, // required
        imageMean: 0.0, // defaults to 117.0
        imageStd: 255.0, // defaults to 1.0
        numResults: 4, // defaults to 5
        threshold: 0.2, // defaults to 0.1
        asynch: true // defaults to true
        );

    List<RecognitionResult> _result = [];

    for (int i = 0; i < recognitions.length; i++) {
      print(recognitions[i]);
      RecognitionResult res = new RecognitionResult();
      res.label = recognitions[i]["label"];
      res.confidence = recognitions[i]["confidence"];
      res.index = recognitions[i]["index"];
      _result.add(res);
    }

    Toast.show("Détection terminé", context, duration: 2);
    Timer(Duration(seconds: 2), () {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => ReceipeScreen(convertToString(_result))));
    });
  }

  String convertToString(List<RecognitionResult> array) {
    print("This is array: ${array[0].label}");
    List<String> result = [];

    for (int i = 0; i < array.length; i++) {
      result.add(array[i].label);
    }

    if (result.length > 1) {
      return result.join(', ');
    } else {
      return result[0];
    }
  }

  void initCameras() async {
    cameras = await availableCameras();
    controller = CameraController(cameras[0], ResolutionPreset.medium);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    });
  }

  Future<String> takePicture() async {
    if (!controller.value.isInitialized) {
      return null;
    }
    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Pictures/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.jpg';

    if (controller.value.isTakingPicture) {
      return null;
    }

    try {
      await controller.takePicture(filePath);
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
    return filePath;
  }

  void logError(String code, String message) =>
      print('Error: $code\nError Message: $message');

  void _showCameraException(CameraException e) {
    logError(e.code, e.description);
    showInSnackBar('Error: ${e.code}\n${e.description}');
  }

  void showInSnackBar(String message) {
    _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text(message)));
  }

  void getImagePath() {
    takePicture().then((String filePath) async {
      if (mounted) {
        setState(() {
          imagePath = filePath;
        });
        if (filePath != null) {
          print('Picture saved to $filePath');
          recognize(filePath);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    initCameras();
    initTensorflow();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!controller.value.isInitialized) {
      return Container();
    }
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: CameraPreview(controller)),
            Container(
              width: double.infinity,
              height: 55,
              child: RaisedButton(
                color: CustomColor.yellowLightColor,
                child: Text(
                  "Prendre une photo",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontFamily: 'Avenir Heavy'),
                ),
                onPressed: () {
                  getImagePath();
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
