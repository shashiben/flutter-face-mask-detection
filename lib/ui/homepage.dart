import 'package:face_mask_detection/ui/camera_screen.dart';
import 'package:face_mask_detection/ui/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Icons.code,
              color: Colors.green,
              size: 25,
              semanticLabel: "Code",
            ),
            onPressed: () {
              gotoWebPage();
            },
          )
        ],
        backgroundColor: Colors.yellow.withOpacity(0.6),
        title: Text(
          'Face Mask Detection',
          style: TextStyle(color: Colors.black, fontFamily: "Gilroy"),
        ),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
            color: Colors.yellow.withOpacity(0.4),
            border: Border.all(color: Colors.yellow, width: 5)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset("assets/images/illustrator.jpeg"),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => CameraPage()));
              },
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 3, color: Colors.white)),
                child: Text(
                  "Live camera",
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: "Gilroy",
                      fontSize: 15,
                      fontWeight: FontWeight.w200),
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LocalStorage()));
              },
              child: Container(
                padding: EdgeInsets.fromLTRB(15, 10, 15, 10),
                decoration: BoxDecoration(
                    color: Colors.yellow,
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(width: 3, color: Colors.white)),
                child: Text(
                  "From Gallery",
                  style: TextStyle(
                      color: Colors.green,
                      fontFamily: "Gilroy",
                      fontSize: 15,
                      fontWeight: FontWeight.w200),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  gotoWebPage() async {
    const url = "https://github.com/shashiben/flutter-face-mask-detection";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw "Could not launch $url";
    }
  }
}
