import "package:rxdart/rxdart.dart";
import "dart:async";

class GlobalBloc{
  final _loginedSubject = BehaviorSubject<bool>();
  Stream<bool> get isLogined => _loginedSubject.stream.distinct();

  final _authSubject = BehaviorSubject<Map<String, String>>();
  Stream<Map<String, String>> get auth => _authSubject.stream.distinct();

  void signin(Map<String, String> info) {
    _loginedSubject.add(true);
    _authSubject.add(info);
  }

  void signout() {
    _loginedSubject.add(false);
    _authSubject.add({});
  }
}