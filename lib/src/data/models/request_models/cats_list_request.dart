import 'network_request.dart';

class CatsListRequest extends NetworkRequest {
  CatsListRequest({
    required this.apiKey,
    required this.host,
    required String url,
  }) : super(url: url);

  String host;
  String apiKey;

  @override
  String? get body => null;

  @override
  Map<String, String> get headers => {};
}
