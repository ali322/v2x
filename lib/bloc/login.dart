import "package:rxdart/rxdart.dart";
import "dart:async";
import "dart:convert";
import "package:http/http.dart" as http;
import "../config/api.dart";

final _usernameTransformer = new StreamTransformer<String, String>.fromHandlers(
  handleData: (val, EventSink evt) {
    if (val == '') {
      evt.addError('用户名不能为空');
    } else {
      evt.add(val);
    }
  }
)
;
final _passwordTransformer = new StreamTransformer<String, String>.fromHandlers(
  handleData: (val, EventSink evt) {
    if (val == '') {
      evt.addError('密码不能为空');
    } else {
      evt.add(val);
    }
  }
);

class LoginBloc{
  final _usernameSubject = BehaviorSubject<String>();
  Stream<String> get username => _usernameSubject.stream.transform(_usernameTransformer).distinct();

  final _passwordSubject = BehaviorSubject<String>();
  Stream<String> get password => _passwordSubject.stream.transform(_passwordTransformer).distinct();

  void Function(String) get changeUsername => _usernameSubject.sink.add;
  void Function(String) get changePassword => _passwordSubject.sink.add;

  Stream<Map<String, String>> credential;

  LoginBloc() {
    credential = Observable.combineLatest2(username, password, (_username, _password) {
      return <String, String>{'username': _username, 'password': _password};
    });
  }

  void validSubmit (){
      if (_usernameSubject.value == null) {
        _usernameSubject.add('');
      }
      if (_passwordSubject.value == null) {
        _passwordSubject.add('');
      }
  }

  Future<String> doLogin(Map<String, String> _credential) async{
    try {
      final _ret = await http.post(apis['signin'], body: _credential).then((ret) => json.decode(ret.body));
      if (_ret["success"] == true) {
        return Future.value(_ret['data']['username']);
      } else {
        return Future.error(_ret['message']);
      }
    } catch(_) {
      return Future.error("登陆失败");
    }
  }

  void dispose() {
    _usernameSubject.close();
    _passwordSubject.close();
  }
}