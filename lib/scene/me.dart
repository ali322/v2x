import "package:flutter/material.dart";
import "./login.dart";
import "../bloc/provider.dart";
import "../bloc/me.dart";

class MeScene extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return new _MeState();
    }
}

class _MeState extends State<MeScene>{
  final _bloc = new MeBloc();
  String _token;

  @override
    void didChangeDependencies() {
      super.didChangeDependencies();
      final _auth = Provider.of(context).auth;
      _token = _auth["token"];
    }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        backgroundColor: Theme.of(context).dividerColor,
        appBar: AppBar(
          elevation: 0.5,
          title: Text('我的', style: TextStyle(fontSize: 16.0))
        ),
        body: _token == null ? Column(
          children: <Widget>[
              _renderAnonymous(context),
              _renderMenus(context)
          ],
        ) : StreamBuilder(
          stream: _bloc.me,
          builder: (BuildContext context, AsyncSnapshot me) {
            if (me.hasData == false) {
              _bloc.fetchMe(_token);
              return Center(child: CircularProgressIndicator(strokeWidth: 2.0));
            }
            return Column(children: <Widget>[
              _renderInfo(context, me.data),
              _renderMenus(context),
              _renderSignout(context)
            ]);
          },
        )
      );
    }

    Widget _renderAnonymous(BuildContext context) {
      return GestureDetector(
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(
            builder: (BuildContext context) => new LoginScene(),
            fullscreenDialog: true
          ));
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
          color: Colors.white,
          child: Row(
            children: <Widget>[
              CircleAvatar(
                radius: 35.0,
                backgroundImage: AssetImage('asset/default_avatar.png'),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text('请登录')
                ),
              )
            ],
          ),
        )
      );
    }

    Widget _renderInfo(BuildContext context, Map<String, String> auth) {
      return Container(
        padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 10.0),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            CircleAvatar(
              radius: 35.0,
              backgroundImage: NetworkImage(auth['avatar']),
            ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(left: 20.0),
                child: Text('欢迎你, ${auth["username"]}')
              ),
            )
          ],
        ),
      );
    }

    Widget _renderMenus(BuildContext context) {
      return Container(
        color: Colors.white,
        margin: const EdgeInsets.only(top: 20.0),
        child: ListView(
          shrinkWrap: true,
          children: ListTile.divideTiles(
            context: context,
            tiles: [
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.description),
                    Padding(child: Text('我的主题', style: TextStyle(fontSize: 16.0)), padding: const EdgeInsets.only(left: 12.0))
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 14.0),
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.comment),
                    Padding(child: Text('我的回复', style: TextStyle(fontSize: 16.0)), padding: const EdgeInsets.only(left: 12.0))
                  ],
                ),
                trailing: Icon(Icons.arrow_forward_ios, size: 14.0),
              )
            ]
          ).toList(),
        )
      );
    }

    Widget _renderSignout(BuildContext context) {
      final _signout = Provider.of(context).signout;
      return Row(children: <Widget>[
        Expanded(
          child: GestureDetector(
            onTap: _signout,
            child: Container(
              height: 40.0,
              margin: const EdgeInsets.only(top: 20.0),
              color: Colors.white,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
              child: Text('退出登陆', style: TextStyle(fontSize: 16.0))
            )
          )
        )
      ]);
    }
}