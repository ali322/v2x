import "dart:convert" show json;
import "package:flutter/material.dart";
import "package:flutter_secure_storage/flutter_secure_storage.dart";

class Provider extends StatefulWidget{
  final Widget child; 
  Provider({Key key, @required this.child}):super(key: key);

  @override
    State<StatefulWidget> createState() {
      return new ProviderState();
    }

    static ProviderState of(BuildContext context) {
      return (context.inheritFromWidgetOfExactType(_Inherited) as _Inherited).data;
    }
}

class ProviderState extends State<Provider>{
  Map<String, String> _auth;

  Map<String, String> get auth => _auth ?? {};

  final _storage = new FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _init();
  }

  void _init() async {
    final _ret = await _storage.read(key: "aid-auth");
    if (_ret != null) {
      setState(() {
        _auth = json.decode(_ret).cast<String, String>();
      });
    }
  }

  void signin(Map<String, String> val) async {
    setState(() {
      _auth = val;
    });
    await _storage.write(key: "aid-auth", value: json.encode(val));
  }


  void signout() async {
    setState(() {
      _auth = null;
    });
    await _storage.delete(key: "aid-auth");
  }

  @override
    Widget build(BuildContext context) {
      return _Inherited(
        data: this,
        child: widget.child
      );
    }
}

class _Inherited extends InheritedWidget{
  final ProviderState data;
  _Inherited({Key key, this.data, Widget child}):super(key: key, child: child);

  @override
  bool updateShouldNotify(_Inherited oldWidget) {
    return true;
  }
}