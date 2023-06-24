
import '../../../domain/entities/config.dart';
import 'json_endpoint.dart';

class JsonConfig extends Config {
  JsonConfig({
    required super.apiKey,
    required super.databaseFileName,
    required super.endpoints,
    required super.host,
  });

  factory JsonConfig.fromDynamic(dynamic map) => JsonConfig(
        apiKey: map[_AttributesKeys.apiKey],
        databaseFileName: map[_AttributesKeys.databaseFileName],
        endpoints: JsonEndpoints.fromDynamic(map[_AttributesKeys.endpoints]),
        host: map[_AttributesKeys.host],
      );
}

abstract class _AttributesKeys {
  static const apiKey = 'apiKey';
  static const databaseFileName = 'databaseFileName';
  static const endpoints = 'endpoints';
  static const host = 'host';
}