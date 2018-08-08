import "package:flutter/material.dart";

class PersistTabview extends StatefulWidget{
  final Widget child;

  PersistTabview({Key key, @required this.child}):super(key: key);

  @override
    State<StatefulWidget> createState() {
      return new _PersistTabviewState();
    }
}

class _PersistTabviewState extends State<PersistTabview> with AutomaticKeepAliveClientMixin{
  @override
  bool get wantKeepAlive => true;

  @override
    Widget build(BuildContext context) {
      return widget.child;
    }
}