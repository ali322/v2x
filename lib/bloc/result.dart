import "dart:async";
import "package:rxdart/rxdart.dart";
import "../model/topic.dart";
import "dart:convert";
import "package:http/http.dart" as http;
import "../config/api.dart";

class ResultBloc{
  Stream<List<Topic>> _result = Stream.empty();
  Stream<List<Topic>> get result => _result;

  ResultBloc(String query) {
    _result = Observable.just(query).asyncMap((String v) {
      return  http.get("${apis['search']}?node_name=$v").then(_mapResponse);
    });
  }

  List<Topic> _mapResponse(http.Response ret) {
    if (ret.body.isEmpty) {
      return [];
    }
    final List<Topic> _topics = json.decode(ret.body).map<Topic>((v) => Topic.fromJson(v)).toList();
    return _topics;
  }
}