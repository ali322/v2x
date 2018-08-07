import "package:rxdart/rxdart.dart";
import "dart:async";

class GlobalBloc{
  final _tokenSubject = ReplaySubject<String>();
  Stream<String> get token => _tokenSubject.stream.distinct();

  void signin(String token) {
    _tokenSubject.add(token);
  }

  void signout() {
    _tokenSubject.add(null);
  }

  void dispose() {
    _tokenSubject.close();
  }
}