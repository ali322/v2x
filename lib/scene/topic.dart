import "package:flutter/material.dart";
import "package:flutter_markdown/flutter_markdown.dart";
import "dart:async";
import "../bloc/topic.dart";
import "../model/topic.dart";
import "../widget/tile.dart";
import "../widget/nothing.dart";

class TopicScene extends StatefulWidget{
  final int id;

  TopicScene({Key key, @required this.id}):super(key: key);

  @override
    State<StatefulWidget> createState() {
      return new _TopicState();
    }
}

class _TopicState extends State<TopicScene>{
  final TopicBloc _bloc = new TopicBloc();
  bool _isLoading = true;

  @override
  initState() {
    super.initState();

    Future.wait(<Future>[
      _bloc.fetchTopic(widget.id),
      _bloc.fetchReplies(widget.id)
    ]).then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
    void dispose() {
      super.dispose();
      _bloc.dispose();
    }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          title: _renderBanner(),
          leading: IconButton(icon: const Icon(Icons.arrow_back_ios), iconSize: 18.0, onPressed: () {
            Navigator.of(context).pop();
          },)
        ),
        body: SafeArea(
          bottom: true,
          child: _isLoading ?
            Center(child: CircularProgressIndicator(strokeWidth: 2.0))
            : SingleChildScrollView(
            child: Column(
              children: <Widget>[
                _renderDetail(),
                _renderReplies()
              ],
            ),
          ),
        )
      );
    }

    Widget _renderBanner() {
      return Center(
        child: StreamBuilder(
          stream: _bloc.result,
          builder: (BuildContext context,AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final _topic = snapshot.data as TopicDetail;
              return Text(_topic.title, style: TextStyle(fontSize: 14.0));
            }
            return Nothing();
          },
        )
      );
    }

    Widget _renderDetail() {
      return StreamBuilder(
        stream: _bloc.result,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final _topic = snapshot.data as TopicDetail;
            return Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: TopicTile(
                    avatar: _topic.authorAvatar,
                    title: Text(_topic.authorName, style: TextStyle(fontSize: 14.0)),
                    subTitle: Text(_topic.createdAt, style: TextStyle(fontSize: 12.0, color: Colors.grey)),
                    trailing: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).dividerColor,
                        borderRadius: BorderRadius.circular(3.0)
                      ),
                      padding: const EdgeInsets.symmetric(horizontal:5.0, vertical: 3.0),
                      child: Text(_topic.nodeName, style: TextStyle(fontSize: 12.0)),
                    ),
                  )
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
                  child: MarkdownBody(data: _topic.content),
                ),
                _topic.replyCount > 0 ? Container(
                  width: MediaQuery.of(context).size.width,
                  color: Theme.of(context).dividerColor,
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 10.0),
                  child: Text('共 ${_topic.replyCount} 条回复' , style: TextStyle(fontSize: 14.0, color: Colors.grey)),
                ) : Container(width: 0.0, height: 0.0)
              ],
            );
          }
          return Nothing();
        }
      );
    }

    Widget _renderReplies() {
      return StreamBuilder(
        stream: _bloc.replies,
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            final _replies = (snapshot.data as List<Reply>)
              .map<Widget>((_reply) {
                return Container(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Column(
                    children: <Widget>[
                      TopicTile(
                        avatar: _reply.authorAvatar,
                        title: Text(_reply.authorName, style: TextStyle(fontSize: 14.0)),
                        subTitle: Text(_reply.createdAt, style: TextStyle(fontSize: 12.0, color: Colors.grey))
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                        decoration: BoxDecoration(
                          border: Border(bottom: BorderSide(color: Theme.of(context).dividerColor))
                        ),
                        child: MarkdownBody(data: _reply.content)
                      )
                    ],
                  )
                );
              }).toList();
            return Column(
              children: _replies,
            );
          }
          return Nothing();
        },
      );
    }
}