import 'package:flutter/material.dart';
import "package:flutter/services.dart";
import "./app.dart";

void main() async {
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.landscapeRight
  ]);
  runApp(App());
}

