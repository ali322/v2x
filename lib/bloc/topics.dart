import "dart:async";
import "package:rxdart/rxdart.dart";
import "dart:convert";
import "package:http/http.dart" as http;
import "../config/api.dart";
import "../model/topic.dart";

class TopicsBloc{
  // ReplaySubject<String> _query = ReplaySubject<String>();
  // Sink<String> get query => _query;

  Stream<List<Topic>> _latest = Stream.empty();
  Stream<List<Topic>> get latest => _latest;


  Stream<List<Topic>> _hot = Stream.empty();
  Stream<List<Topic>> get hot => _hot;


  TopicsBloc() {
    _latest = Stream.fromFuture(http.get(apis["latest_topics"])).map((ret) {
      final List<Topic> _topics = json.decode(ret.body).map<Topic>((v) {
        return Topic.fromJson(v);
      }).toList();
      return _topics;
    });
  }

  void fetchHot() {
    _hot = Stream.fromFuture(http.get(apis["hot_topics"]).then((ret) {
      final _result = json.decode(ret.body);
      print('===>$_result');
    }).catchError((err) {
      print('err==>$err');
    })).asBroadcastStream();
  }
}
