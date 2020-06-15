import 'dart:io';
import 'package:camera/camera.dart';
import 'package:tflite/tflite.dart';

class TensorFlowServices {
  loadModel() async {
    await Tflite.loadModel(
      model: "assets/models/model.tflite",
      labels: "assets/texts/lables.txt",
    );
  }

  predictImage(File image) async {
    var recog = await Tflite.runModelOnImage(
      path: image.path,
      numResults: 2,
      threshold: 0.5,
      imageMean: 127.5,
      imageStd: 127.5,
    );
    return recog;
  }

  runModelonFrame(CameraImage img) {
    var run = Tflite.runModelOnFrame(
      bytesList: img.planes.map((Plane plane) {
        return plane.bytes;
      }).toList(),
      imageWidth: img.width,
      imageHeight: img.height,
      numResults: 2,
    );
    return run;
  }
}
