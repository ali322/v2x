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
  final _pageController = new PageController(initialPage: 0);
  int _pageIndex = 0;
  final _pages = <Widget>[
    TopicsScene(),
    ExplorerScene(),
    FavoriteScene(),
    MeScene()
  ];

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (int i) {
            if (i != _pageIndex) {
              setState(() {
                _pageIndex = i;
              });
            }
          },
          children: _pages,
        ),
        bottomNavigationBar: CupertinoTabBar(
          // activeColor: Theme.of(context).primaryColor,
          currentIndex: _pageIndex,
          onTap: (int i) {
            _pageController.jumpToPage(_pageIndex);
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