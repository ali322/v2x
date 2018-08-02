import "package:flutter/material.dart";
import "../bloc/login.dart";

class LoginScene extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return new _LoginState();
    }
}

class _LoginState extends State<LoginScene>{
  final _bloc = new LoginBloc();

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.0,
          leading: IconButton(icon: const Icon(Icons.close), iconSize: 18.0, onPressed: () {
            Navigator.of(context).maybePop();
          }),
        ),
        body: Container(
          padding: const EdgeInsets.only(left: 50.0, right: 50.0, top: 50.0),
          child: Form(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Container(
                  width: 60.0,
                  height: 60.0,
                  margin: const EdgeInsets.only(bottom: 30.0),
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage('asset/v2x_logo.png')),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                StreamBuilder(
                  stream: _bloc.username,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return TextField(
                      onChanged: _bloc.changeUsername,
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText: '请输入用户名',
                        hintStyle: TextStyle(fontSize: 14.0),
                        errorText: snapshot.error 
                      ),
                    );
                  },
                ),
                StreamBuilder(
                  stream: _bloc.password,
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    return TextField(
                      onChanged: _bloc.changePassword,
                      decoration: InputDecoration(
                        // border: InputBorder.none,
                        hintText: '请输入密码',
                        hintStyle: TextStyle(fontSize: 14.0),
                        errorText: snapshot.error
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: MaterialButton(
                    minWidth: MediaQuery.of(context).size.width,
                    elevation: 1.0,
                    color: Theme.of(context).buttonColor,
                    textColor: Colors.white,
                    onPressed: () {
                      _bloc.doLogin();
                    },
                    child: Text('登陆'),
                  )
                )
              ],
            ),
          ),
        )
      );
    }
}