import "package:flutter/material.dart";
import "../model/node.dart";
import "../bloc/node.dart";
import "./result.dart";

class ExplorerScene extends StatefulWidget{
  @override
    State<StatefulWidget> createState() {
      return new _ExplorerState();
    }
}

class _ExplorerState extends State<ExplorerScene>{
  final NodeBloc _bloc = new NodeBloc();
  bool _filtering = false;

  @override
    void initState() {
      super.initState();
      _bloc.fetchNodes();
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
          title: _filtering ? _renderFilter() : Text('节点', style: TextStyle(fontSize: 14.0)),
          actions: <Widget>[
            IconButton(icon: Icon(_filtering ? Icons.close : Icons.filter_list), iconSize: 18.0, onPressed: () {
              setState(() {
                if (!_filtering) {
                  _bloc.query.add('');
                }
                _filtering = !_filtering;
              });
            })
          ],
        ),
        body: StreamBuilder(
          stream: _bloc.nodes,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              final _nodes = snapshot.data as List<Node>;
              return CustomScrollView(
                primary: false,
                slivers: <Widget>[
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 10.0),
                    sliver: SliverGrid.count(
                      childAspectRatio: 1.5,
                      crossAxisCount: 4,
                      children: _nodes.map<Widget>((Node _node) => _renderNode(context, _node)).toList(),
                    ),
                  )
                ],
              );
            }
            return Center(child: CircularProgressIndicator(strokeWidth: 2.0));
          },
        ),
      );
    }

    Widget _renderNode(BuildContext context, Node node) {
      return Container(
        alignment: Alignment.center,
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).push(new MaterialPageRoute(
              builder: (BuildContext context) {
                return new ResultScene(query: node.name);
              }
            ));
          },
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).dividerColor,
              borderRadius: BorderRadius.circular(3.0)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 5.0, vertical: 3.0),
            child: Text(node.name),
          )
        )
      );
    }

    Widget _renderFilter() {
      return TextField(
        onChanged: _bloc.query.add,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.0),
          hintText: '输入节点名称'
        ),
      );
    }
}