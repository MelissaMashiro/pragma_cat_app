import 'dart:convert';
import 'dart:io';

import '../../../domain/entities/cat.dart';
import '../../../domain/entities/endpoints.dart';
import '../../models/network/network_client.dart';
import '../../models/request_models/cats_list_request.dart';

abstract class CatAppRemoteDatasource {
  Future<List<Cat>> getCatsList();
}

class CatAppRemoteDatasourceImpl implements CatAppRemoteDatasource {
  CatAppRemoteDatasourceImpl({
    required String apikey,
    required String host,
    required Endpoints endpoints,
    required NetworkClient networkClient,
  })  : _apiKey = apikey,
        _host = host,
        _endpoints = endpoints,
        _networkClient = networkClient;

  final String _apiKey;
  final String _host;
  final Endpoints _endpoints;
  final NetworkClient _networkClient;

  @override
  Future<List<Cat>> getCatsList() async {
    final response = await _networkClient.get(
      CatsListRequest(
        apiKey: _apiKey,
        host: _host,
        url: _endpoints.catApiUrl,
      ),
    );

    if (response.statusCode != HttpStatus.ok) {
      throw Exception(response.body);
    }

    final body = json.decode(
      utf8.decode(response.bodyBytes),
    );

    return (body as List).map((data) => Cat.fromJson(data)).toList();
  }
}
