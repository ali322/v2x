import "package:flutter/material.dart";
import "../bloc/topics.dart";
import "../model/topic.dart";
import "../widget/tile.dart";
import "./topic.dart";

class TopicsScene extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return new _TopicsState();
    }
}

class _TopicsState extends State<TopicsScene> with TickerProviderStateMixin{
  final _bloc = new TopicsBloc();
  TabController _tabController;
  VoidCallback _onChange;
  List<Topic> _latest;
  List<Topic> _hot;

  @override
  void initState() {
    super.initState();
    _tabController = new TabController(vsync:  this, length: 2);
    _onChange = () {
      if (_tabController.index == 1 && _hot == null) {
        _bloc.fetchHot();
      }
    };
    _tabController.addListener(_onChange);

    _bloc.fetchLatest();
    _bloc.latest.listen((data) {
      setState(() {
        _latest = data;
      });
    });

    _bloc.hot.listen((data) {
      setState(() {
        _hot = data;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.removeListener(_onChange);
    _tabController.dispose();
  }

  Widget _renderRow(Topic topic) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(new MaterialPageRoute(
          builder: (BuildContext context) {
            return new TopicScene(id: topic.id,);
          }
        ));
      },
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

  Widget _renderTopics({type: 'latest'}) {
    final List<Topic> _list = type == 'hot' ? _hot : _latest;
    if (_list == null) {
      return Center(
        child: CircularProgressIndicator(strokeWidth: 2.0),
      );
    }
    return Container(
      child: RefreshIndicator(
        onRefresh: () async{
          return type == 'latest' ? _bloc.fetchLatest() : _bloc.fetchHot();
        },
        child: ListView.builder(
          itemCount: _list.length,
          itemBuilder: (BuildContext context, int i) => _renderRow(_list[i]),
        ),
      )
    );
  }

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          elevation: 0.5,
          titleSpacing: 0.0,
          bottom: null,
          title: Align(
            alignment: Alignment.bottomCenter,
            child: TabBar(
              controller: _tabController,
              tabs: <Widget>[
                Tab(text:'最新'),
                Tab(text:'热门'),
              ],
            ),
          )
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            _renderTopics(),
            _renderTopics(type: 'hot')
          ],
        )
      );
    }
}