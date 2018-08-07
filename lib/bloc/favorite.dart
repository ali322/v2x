import "dart:async";
import "package:rxdart/rxdart.dart";
import "../model/topic.dart";
import "dart:convert";
import "package:http/http.dart" as http;
import "../config/api.dart";

class FavoriteBloc{
  final _favoritesSubject = BehaviorSubject<List<Topic>>();
  Stream<List<Topic>> get favorites => _favoritesSubject.stream.distinct();

  Future<Null> fetchFavorites() async{
    try {
      final _ret = await http.get('${apis["hot_topics"]}').then(_mapFavorites);
      _favoritesSubject.add(_ret);
    } catch(err) {
      _favoritesSubject.addError(err);
    }
  }

  List<Topic> _mapFavorites(http.Response ret) {
    final List<Topic> _topics = json.decode(ret.body).map<Topic>((v) => Topic.fromJson(v)).toList();
    return _topics;
  }

  void dispose() {
    _favoritesSubject.close();
  }
}