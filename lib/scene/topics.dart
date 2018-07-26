import "package:flutter/material.dart";
import "../bloc/topics.dart";
import "../model/topic.dart";

class TopicsScene extends StatelessWidget{
  final _bloc = new TopicsBloc();

  @override
    Widget build(BuildContext context) {
      return Scaffold(
        body: Container(
          child: StreamBuilder(
            stream: _bloc.latest,
            builder: (BuildContext context,AsyncSnapshot snapshot) {
              if (snapshot.hasError) {
                return Center(child: Text('请求出错'));
              }
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int i) {
                  final _topic = snapshot.data[i] as Topic;
                  return ListTile(
                    title: Text(_topic.title),
                  );
                },
              );
            },
          ),
        ),
      );
    }
}