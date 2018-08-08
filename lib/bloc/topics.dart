import "dart:async";
import "dart:convert";
import "package:rxdart/rxdart.dart";
import "package:http/http.dart" as http;
import "../config/api.dart";
import "../model/topic.dart";

class FetchLatest{}

class FetchHot{}

class TopicsBloc{
  Stream<List<Topic>> _latest = Stream.empty();
  Stream<List<Topic>> get latest => _latest;

  Stream<List<Topic>> _hot = Stream.empty();
  Stream<List<Topic>> get hot => _hot;

  final _actionSubject = ReplaySubject<dynamic>();

  void fetchLatest() {
    _actionSubject.sink.add(FetchLatest());
  }

  void fetchHot() {
    _actionSubject.sink.add(FetchHot());
  }

  TopicsBloc() {
    _latest = Observable(_actionSubject.stream).ofType(TypeToken<FetchLatest>())
      .asyncMap((_) => http.get(apis['latest_topics']).then(_mapResponse))
      .asBroadcastStream();

    _hot = Observable(_actionSubject.stream).ofType(TypeToken<FetchHot>())
      .asyncMap((_) => http.get(apis['hot_topics']).then(_mapResponse))
      .asBroadcastStream();
  }

  List<Topic> _mapResponse(http.Response ret) {
    if (ret.body.isEmpty) {
      return [];
    }
    final List<Topic> _topics = json.decode(ret.body).map<Topic>((v) => Topic.fromJson(v)).toList();
    return _topics;
  }

  void dispose() {
    _actionSubject.close();
  }
}
