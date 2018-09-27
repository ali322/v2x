import "package:flutter/material.dart";
import "package:flutter/cupertino.dart";
import "../widget/persist_tabview.dart";
import "../widget/scene.dart";
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
  int _pageIndex = 0;
  final _pages = <Widget>[
    PersistTabview(child: TopicsScene()),
    PersistTabview(child: ExplorerScene()),
    PersistTabview(child: FavoriteScene()),
    PersistTabview(child: MeScene()),
  ];

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Stack(
        children: List.generate(_pages.length, (int i) {
          return Offstage(
              offstage: i != _pageIndex,
              child: _pages[i]
            );
          }),
        ),
        bottomNavigationBar: CupertinoTabBar(
          currentIndex: _pageIndex,
          onTap: (int i) {
            setState(() {
              _pageIndex = i;
            });
            if (_pages[i] is Scene) {
              final _scene = _pages[i] as Scene;
              if (_scene.initialized == false) {
                _scene.initialized = true;
              }
            }
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