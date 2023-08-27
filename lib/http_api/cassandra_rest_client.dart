import 'package:http/http.dart' as http;

const String DB_REST_URL =
    'https://be420919-f9f0-4654-a712-d47513bce79f-asia-south1.apps.astra.datastax.com/api/rest/v2/keyspaces/stargate/satyajit_table/rows';

class CassandraRestClient extends http.BaseClient {
  final String userAgent;
  final http.Client _inner;

  CassandraRestClient(this.userAgent, this._inner);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['user-agent'] = userAgent;
    return _inner.send(request);
  }
}
