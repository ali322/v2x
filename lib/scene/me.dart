import "package:flutter/material.dart";
import "./login.dart";
import "../bloc/provider.dart";

class MeScene extends StatelessWidget{
  @override
    Widget build(BuildContext context) {
      final _auth = Provider.of(context).auth;
      return Scaffold(
        backgroundColor: Theme.of(context).dividerColor,
        appBar: AppBar(
          elevation: 0.5,
          title: Text('我的', style: TextStyle(fontSize: 16.0))
        ),
        body: Column(
          children: <Widget>[
            StreamBuilder(
              stream: _auth,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                return snapshot.hasData ? _renderInfo(context, snapshot.data) : _renderAnonymous(context);
              },
            ),
            _renderMenus(context)
          ]
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
}