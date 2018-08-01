import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "./topics.dart";
import "./explorer.dart";
import "./favorite.dart";
import "./me.dart";

class IndexScene extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return new _IndexState();
    }
}

class _IndexState extends State<IndexScene>{
  int _tabbarIndex = 0;

  List<Widget> _renderStacks() {
    return <Widget>[
      TopicsScene(),
      ExplorerScene(),
      FavoriteScene(),
      MeScene()
    ];
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: IndexedStack(
          index: _tabbarIndex,
          children: _renderStacks(),
        ),
        bottomNavigationBar: CupertinoTabBar(
          // activeColor: Theme.of(context).primaryColor,
          currentIndex: _tabbarIndex,
          onTap: (int i) {
            setState(() {
              _tabbarIndex = i;
            });
          },
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text('主题')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.explore),
              title: Text('发现')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              title: Text('收藏')
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              title: Text('我的')
            )
          ],
        ),
      );
    }
}