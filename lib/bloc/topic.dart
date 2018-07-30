import "dart:async";
import "dart:convert";
import "package:rxdart/rxdart.dart";
import "package:http/http.dart" as http;
import "../config/api.dart";
import "../model/topic.dart";

class TopicBloc{
  BehaviorSubject<Topic> _result = BehaviorSubject<Topic>();
  Stream<Topic> get result => _result.stream;

  BehaviorSubject<List<Reply>> _replies = BehaviorSubject<List<Reply>>();
  Stream<List<Reply>> get replies => _replies.stream;

  Future<Null> fetchTopic(int id) async{
    try {
      final _topic = await http.get('${apis["topic"]}?id=$id').then(_mapResult);
      _result.add(_topic);
    } catch(err) {
      _result.addError(err);
    }
  }

  Topic _mapResult(http.Response ret) {
    return TopicDetail.fromJson(json.decode(ret.body)[0]);
  }

  Future<Null> fetchReplies(int id) async{
    try {
      final _ret = await http.get('${apis["replies"]}?topic_id=$id&page=1&page_size=100').then(_mapReplies);
      _replies.add(_ret);
    } catch(err) {
      _replies.addError(err);
    }
  }

  List<Reply> _mapReplies(http.Response ret) {
    final List<Reply> _replies = json.decode(ret.body).map<Reply>((v) => Reply.fromJson(v)).toList();
    return _replies;
  }


  void dispose() {
    _result.close();
    _replies.close();
  }
}