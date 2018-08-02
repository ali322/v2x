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
  final _usernameSubject = BehaviorSubject<String>();
  Stream<String> get username => _usernameSubject.stream.transform(_usernameTransformer).distinct();

  final _passwordSubject = BehaviorSubject<String>();
  Stream<String> get password => _passwordSubject.stream.transform(_passwordTransformer).distinct();

  void Function(String) get changeUsername => _usernameSubject.sink.add;
  void Function(String) get changePassword => _passwordSubject.sink.add;

  final _loginController = StreamController<Null>();

  Stream<Map<String, String>> validSubmit;

  LoginBloc() {
    validSubmit = Observable.combineLatest2(username, password, (_username, _password) {
      return <String, String>{'username': _username, 'password': _password};
    });

    Observable(_loginController.stream).withLatestFrom(validSubmit, (_, v) => v)
      .listen((data) {
        print('===>$data');
      }).onError((err) {
        print('$err');
      });
  }

  void doLogin() {
    if (_usernameSubject.value == null) {
      _usernameSubject.add('');
    }
    if (_passwordSubject.value == null) {
      _passwordSubject.add('');
    }
    _loginController.add(null);
  }

  void dispose() {
    _usernameSubject.close();
    _passwordSubject.close();
  }
}