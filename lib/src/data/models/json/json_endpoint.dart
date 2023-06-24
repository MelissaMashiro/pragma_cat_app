 

import '../../../domain/entities/endpoints.dart';

class JsonEndpoints extends Endpoints {
  JsonEndpoints({
    required super.catApiUrl,
  });

  factory JsonEndpoints.fromDynamic(dynamic map) => JsonEndpoints(
        catApiUrl: map[_AttributesKeys.catApiUrl],
       );
}

abstract class _AttributesKeys {
  static const catApiUrl = 'catApiUrl';
}