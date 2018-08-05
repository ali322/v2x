import "package:flutter/material.dart";
import "./global.dart";

class Provider extends InheritedWidget{
  final bloc = new GlobalBloc();

  Provider({Key key, Widget child}):super(key: key,child: child);

  @override
  bool updateShouldNotify(Provider old) => true;

  static GlobalBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}