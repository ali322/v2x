import "package:flutter/material.dart";
import "../bloc/favorite.dart";
import "../model/topic.dart";
import "../widget/tile.dart";

class FavoriteScene extends StatelessWidget{
  final _bloc = new FavoriteBloc();

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: Text('收藏', style: TextStyle(fontSize: 14.0)),
        ),
        body: SafeArea(
          bottom: true,
          child: StreamBuilder(
            stream: _bloc.favorites,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return _renderTopics(snapshot.data);
              }
              _bloc.fetchFavorites();
              return Center(child: CircularProgressIndicator(strokeWidth: 2.0));
            },
          ),
        ),
      );
    }

  Widget _renderTopics(_list) {
    if (_list == null) {
      return Center(
        child: CircularProgressIndicator(strokeWidth: 2.0),
      );
    }
    return Container(
      child: RefreshIndicator(
        onRefresh: () {
          return _bloc.fetchFavorites();
        },
        child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int i) => _renderRow(_list[i]),
        ),
      )
    );
  }

  Widget _renderRow(Topic topic) {
    return InkWell(
      child: Column(
        children: <Widget>[
          TopicTile(
            avatar: topic.authorAvatar,
            title: Text(topic.authorName, style: TextStyle(fontSize: 14.0)),
            subTitle: Text(topic.createdAt, style: TextStyle(fontSize: 12.0, color: Colors.grey)),
            trailing: Text(topic.replyCount > 0 ? '${topic.replyCount} 条回复' : '暂无回复'),
          ),
          Container(
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.all(10.0),
            child: Text(topic.title),
          )
        ],
      ),
    );
  }
}