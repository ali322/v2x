import "package:rxdart/rxdart.dart";
import "dart:async";
import "dart:convert";
import "package:http/http.dart" as http;
import "../config/api.dart";
import "../common/helper.dart";

class GlobalBloc{
  final _loginedSubject = BehaviorSubject<bool>();
  Stream<bool> get isLogined => _loginedSubject.stream.distinct();

  final _tokenSubject = ReplaySubject<String>();

  Stream<Map<String, String>> auth;

  GlobalBloc() {
    auth = _tokenSubject.distinct()
      .asyncMap((String v) => http.get('${apis["member"]}?username=$v'))
      .map((ret) {
        final _ret = json.decode(ret.body);
        return <String, String>{
          'username': _ret['username'],
          'avatar':  formatUrl(_ret['avatar_normal']),
          'createdAt': fromNow(_ret['created'])
        };
      }).asBroadcastStream();
  }

  void signin(String token) {
    _loginedSubject.add(true);
    _tokenSubject.add(token);
  }

  void signout() {
    _loginedSubject.add(false);
    // _authSubject.add({});
  }

  @override
  void dispose() {
    _loginedSubject.close();
    _tokenSubject.close();
  }
}