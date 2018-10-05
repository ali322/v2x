import "package:flutter/material.dart";
import "../bloc/result.dart";
import "../model/topic.dart";
import "../widget/tile.dart";

class ResultScene extends StatelessWidget{
  final String query;
  final ResultBloc _bloc;

  ResultScene({Key key, @required this.query}):
    this._bloc = new ResultBloc(query),
    super(key: key);

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text(query, style: TextStyle(fontSize: 14.0)),
          elevation: 0.5,
          leading: IconButton(icon: Icon(Icons.arrow_back_ios), iconSize: 18.0, onPressed: (){
            Navigator.of(context).pop();
          }),
        ),
        body: StreamBuilder(
          stream: _bloc.result,
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return _renderTopics(snapshot.data as List<Topic>);
            }
            return Center(child: CircularProgressIndicator(strokeWidth: 2.0));
          },
        )
      );
    }

    Widget _renderTopics(_list) {
      if (_list == null) {
        return Center(
          child: CircularProgressIndicator(strokeWidth: 2.0),
        );
      }
      return ListView.builder(
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int i) => _renderRow(_list[i]),
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