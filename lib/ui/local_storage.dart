import 'dart:io';
import 'package:face_mask_detection/services/tensorflow_services.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class LocalStorage extends StatefulWidget {
  @override
  _LocalStorageState createState() => _LocalStorageState();
}

class _LocalStorageState extends State<LocalStorage> {
  final TensorFlowServices _tensorFlowServices = TensorFlowServices();
  File _image;
  bool _loading = false;
  List _recognitions;
  ImagePicker _picker = ImagePicker();
  String text = "";
  PickedFile _imageFile;
  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      setState(() {
        _loading = false;
      });
    });
  }

  loadModel() async {
    _tensorFlowServices.loadModel();
  }

  selectImage() async {
    _imageFile = await _picker.getImage(source: ImageSource.gallery);
    if (_imageFile == null) return;
    setState(() {
      _loading = true;
      _image = File(_imageFile.path);
    });
    predictImage(_image);
  }

  predictImage(File image) async {
    var recognitions =await _tensorFlowServices.predictImage(image);
    setState(() {
      _loading = false;
      _recognitions = recognitions;
      text = _recognitions[0]["label"];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.image,
          color: Colors.yellow,
        ),
        tooltip: "Pick Image from gallery",
        backgroundColor: Colors.green,
        onPressed: selectImage,
      ),
      body: _loading
          ? Container(
              color: Colors.yellowAccent,
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            )
          : Container(
              color: Colors.yellow.withOpacity(0.4),
              width: MediaQuery.of(context).size.width,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  _image == null
                      ? Container(
                          child: Text(
                            "Select an Image to Show Preview",
                            style: TextStyle(
                                fontSize: 20,
                                color: Colors.green,
                                fontFamily: "Gilroy"),
                          ),
                        )
                      : Image.file(
                          _image,
                          height: MediaQuery.of(context).size.height / 2 + 60,
                          width: MediaQuery.of(context).size.width - 80,
                        ),
                  SizedBox(
                    height: 20,
                  ),
                  _recognitions != null
                      ? Text(
                          "$text",
                          style: TextStyle(
                              color: text == "without_mask"
                                  ? Colors.red
                                  : Colors.green,
                              fontSize: 20.0,
                              fontFamily: "Gilroy"),
                        )
                      : Container()
                ],
              ),
            ),
    );
  }
}
