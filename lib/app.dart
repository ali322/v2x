import "package:flutter/material.dart";
import "./scene/index.dart";

class App extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: Colors.white,
          bottomAppBarColor: Color(0xFFF7F7F7),
          dividerColor: Color(0xFFEEEEEE),
          hintColor: Color(0xFFDDDDDD),
          buttonColor: Color(0xFF4B6EFF),
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