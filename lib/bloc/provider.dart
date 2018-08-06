import "package:flutter/material.dart";
import "./global.dart";

class Provider extends InheritedWidget{
  final Widget child;
  final GlobalBloc bloc = new GlobalBloc();

  Provider({Key key, @required this.child, }):super(key: key,child: child);

  @override
  bool updateShouldNotify(Provider old) {
    return true;
  }

  static GlobalBloc of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(Provider) as Provider).bloc;
  }
}