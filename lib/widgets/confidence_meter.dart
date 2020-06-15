import 'package:flutter/material.dart';

class ConfidenceMeter extends StatefulWidget {
  final List<dynamic> results;

  const ConfidenceMeter({Key key, this.results}) : super(key: key);

  @override
  _ConfidenceMeterState createState() => _ConfidenceMeterState();
}

class _ConfidenceMeterState extends State<ConfidenceMeter> {
  double _confidence = 0;
  String label;
  double threshold = 0.5;
  set confidence(double value) => setState(() {
        _confidence = value;
      });
  List<dynamic> con = [];
  getValue() {
    if (widget.results == null) {
      return null;
    }
    if (widget.results.length > 1) {
      final String firstLabel = widget.results.first["label"] as String;
      final double firstConfidence =
          widget.results.first["confidence"] as double;

      final String secondLabel = widget.results.last["label"] as String;
      final double secondConfidence =
          widget.results.last["confidence"] as double;

      if (firstConfidence > secondConfidence) {
        label = firstLabel;
        confidence = firstConfidence;
      } else {
        label = secondLabel;
        confidence = secondConfidence;
      }
    }
    if (widget.results.length == 1) {
      label = widget.results.first["label"] as String;
      confidence = widget.results.first["confidence"] as double;
    }
    if (confidence < threshold) {
      print("Dont shake camera");
    }
  }

  double get confidence => _confidence;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: LinearProgressIndicator(
        value: confidence,
        valueColor: AlwaysStoppedAnimation<Color>(
            label == "with_mask" ? Colors.greenAccent : Colors.red),
        minHeight: 15,
      ),
    );
  }
}
