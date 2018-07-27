import "dart:async";
import "dart:convert";
import "package:rxdart/rxdart.dart";
import "package:http/http.dart" as http;
import "../config/api.dart";
import "../model/topic.dart";

class TopicsBloc{
  BehaviorSubject<List<Topic>> _latest = BehaviorSubject<List<Topic>>();
  Stream<List<Topic>> get latest => _latest.stream;

  BehaviorSubject<List<Topic>> _hot = BehaviorSubject<List<Topic>>();
  Stream<List<Topic>> get hot => _hot.stream;

  Future<Null> fetchTopics({type: 'latest'}) async{
    final _api = apis[type == 'hot' ? 'hot_topics' : 'latest_topics'];
    final _controller = type == 'hot' ? _hot : _latest;
    try {
      final _topics = await http.get(_api).then(_mapResponse);
      _controller.add(_topics);
    } catch(err) {
      _controller.addError(err);
    }
  }

  List<Topic> _mapResponse(http.Response ret) {
    final List<Topic> _topics = json.decode(ret.body).map<Topic>((v) {
      return Topic.fromJson(v);
    }).toList();
    return _topics;
  }
}
