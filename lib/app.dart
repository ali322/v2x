import "package:flutter/material.dart";
import "./scene/index.dart";

class App extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(
          primaryColor: Colors.lightBlueAccent,
          bottomAppBarColor: Color(0xFFF7F7F7),
          iconTheme: new IconThemeData(
            color: Color(0xFF666666)
          ),
          textTheme: new TextTheme(
            body1: new TextStyle(color: Color(0xFF333333), fontSize: 14.0)
          )
        ),
        debugShowCheckedModeBanner: false,
        home: IndexScene()
      );
    }
}