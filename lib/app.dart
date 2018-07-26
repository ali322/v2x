import "package:flutter/material.dart";
import "./scene/index.dart";

class App extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.lightBlueAccent,
          bottomAppBarColor: Color(0xFFF7F7F7)
        ),
        debugShowCheckedModeBanner: false,
        home: IndexScene()
      );
    }
}