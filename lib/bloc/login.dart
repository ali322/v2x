import "package:rxdart/rxdart.dart";
import "dart:async";

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
  BehaviorSubject<String> _usernameSubject = BehaviorSubject<String>();
  Stream<String> get username => _usernameSubject.stream.transform(_usernameTransformer).distinct();

  BehaviorSubject<String> _passwordSubject = BehaviorSubject<String>();
  Stream<String> get password => _passwordSubject.stream.transform(_passwordTransformer).distinct();

  void Function(String) get changeUsername => _usernameSubject.sink.add;
  void Function(String) get changePassword => _passwordSubject.sink.add;

  LoginBloc() {

  }


  void dispose() {
    _usernameSubject.close();
    _passwordSubject.close();
  }
}