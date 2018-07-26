import "package:http/http.dart" as http$;
import "dart:async";
import "dart:convert";

class HttpClient extends http$.BaseClient{
  final http$.Client _client;

  HttpClient(this._client);

  Future<http$.StreamedResponse> send(http$.BaseRequest request) {
    return _client.send(request);
  }
}

HttpClient http = new HttpClient(new http$.Client());

