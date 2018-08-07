import "package:flutter/material.dart";
import "../bloc/login.dart";
import "../bloc/provider.dart";

class LoginScene extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return new _LoginState();
    }
}

class _LoginState extends State<LoginScene>{
  final _bloc = new LoginBloc();
  bool _isSubmiting = false;

  @override
    Widget build(BuildContext context) {
      final _signin = Provider.of(context).signin;
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
                      obscureText: true,
                      decoration: InputDecoration(
                        hintText: '请输入密码',
                        hintStyle: TextStyle(fontSize: 14.0),
                        errorText: snapshot.error
                      ),
                    );
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: StreamBuilder(
                    stream: _bloc.credential,
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        elevation: 1.0,
                        color: Theme.of(context).buttonColor,
                        textColor: Colors.white,
                        onPressed: _isSubmiting ? null : () {
                          _bloc.validSubmit();
                          if (snapshot.hasData) {
                            setState(() {
                              _isSubmiting = true;
                            });
                            _bloc.doLogin(snapshot.data).then((String token) {
                              _signin(token);
                              Navigator.of(context).pop();
                            }).catchError((err) {
                              print(err);
                              Scaffold.of(context).showSnackBar(SnackBar(
                                content: Text(err.toString()),
                              ));
                            }).whenComplete(() {
                              setState(() {
                                _isSubmiting = false;
                              });
                            });
                          }
                        },
                        child: Text('登陆'),
                      );
                    },
                  )
                )
              ],
            ),
          ),
        )
      );
    }
}