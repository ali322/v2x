import "dart:async";
import "dart:convert";
import "package:rxdart/rxdart.dart";
import "package:http/http.dart" as http;
import "../config/api.dart";
import "../model/node.dart";

class NodeBloc{
  BehaviorSubject<List<Node>> _nodes = BehaviorSubject<List<Node>>();
  Stream<List<Node>> get nodes => _nodes.stream;

  ReplaySubject<String> _query = ReplaySubject<String>();
  Sink<String> get query => _query;

  List<Node> _ret;

  NodeBloc() {
    _query.stream.distinct().listen((v) {
      _nodes.add(_ret.where((_node) => _node.name.startsWith(v)).toList());
    });
  }

  Future<Null> fetchNodes() async{
    try {
      _ret = await http.get('${apis["nodes"]}').then(_mapNodes);
      _nodes.add(_ret);
    } catch(err) {
      _nodes.addError(err);
    }
  }

  List<Node> _mapNodes(http.Response ret) {
    final _nodes = json.decode(ret.body).map<Node>((v) => Node.fromJson(v)).toList();
    return _nodes;
  }

  void dispose() {
    _nodes.close();
    _query.close();
  }
}