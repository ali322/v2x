import "dart:async";
import "package:rxdart/rxdart.dart";
import "dart:convert";
import "package:http/http.dart" as http;
import "../config/api.dart";
import "../common/helper.dart";

class MeBloc{
  final _meSubject = BehaviorSubject<Map<String, String>>();
  Stream<Map<String, String>> get me => _meSubject.stream.distinct();

  Future<Null> fetchMe(String token) async{
    try {
      final _ret = await http.get('${apis["member"]}?username=$token').then(_mapMe);
      _meSubject.add(_ret);
    } catch(err) {
      _meSubject.addError(err);
    }
  }

  Map<String, String> _mapMe(http.Response ret) {
    final _me = json.decode(ret.body);
    return <String, String>{
      'username': _me['username'],
      'avatar':  formatUrl(_me['avatar_large']),
      'createdAt': fromNow(_me['created'])
    };
  }

  void dispose() {
    _meSubject.close();
  }
}