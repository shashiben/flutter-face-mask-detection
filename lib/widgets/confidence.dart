import 'dart:async';

import 'package:face_mask_detection/app/colors.dart';
import 'package:face_mask_detection/app/strings.dart';
import 'package:flutter/material.dart';

class ConfidenceMeter extends StatefulWidget {
  const ConfidenceMeter({
    @required List<dynamic> results,
    this.threshold = 0.5,
  }) : _results = results;
  final List<dynamic> _results;
  final double threshold;

  @override
  _ConfidenceMeterState createState() => _ConfidenceMeterState();
}

class _ConfidenceMeterState extends State<ConfidenceMeter> {
  String _label;
  double _confidence = 0;

  set label(String value) => setState(() {
        _label = value;
      });

  set confidence(double value) => setState(() {
        _confidence = value;
      });

  String get label => _label;

  double get confidence => _confidence;

  Color _changeBorderColor(
    BuildContext context,
    List<dynamic> divisions,
  ) {
    if (divisions == null) {
      return transparent;
    }

    if (divisions.length > 1) {
      final String firstLabel = divisions.first[labelString] as String;
      final double firstConfidence =
          divisions.first[confidenceString] as double;

      final String secondLabel = divisions.last[labelString] as String;
      final double secondConfidence =
          divisions.last[confidenceString] as double;

      if (firstConfidence > secondConfidence) {
        label = firstLabel;
        confidence = firstConfidence;
      } else {
        label = secondLabel;
        confidence = secondConfidence;
      }
    }
    if (divisions.length == 1) {
      label = divisions.first[labelString] as String;
      confidence = divisions.first[confidenceString] as double;
    }

    if (confidence < widget.threshold) {
      scheduleMicrotask(() => print(dontShake));

      return transparent;
    }

    if (label == withoutMask) {
      return red;
    }

    if (label == withMask) {
      return greenAccent;
    }

    return transparent;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            border: Border.fromBorderSide(BorderSide(
              color: _changeBorderColor(
                context,
                widget._results,
              ),
              width: 10,
            )),
          ),
        ),
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 85,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              SizedBox(
                height: MediaQuery.of(context).padding.top,
              ),
              Align(
                alignment: Alignment.center,
                child: Text(
                  label == withMask
                      ? wearingMask +
                          "${(confidence * 100).toStringAsFixed(0)}%"
                      : noMask + "${(confidence * 100).toStringAsFixed(0)}%",
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: label == withMask ? greenAccent : red,
                      ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
