import 'package:dartz/dartz.dart';

import '../entities/cat.dart';
import '../entities/failure.dart';

abstract class CatAppRepository {
  Future<Either<Failure, List<Cat>>> getCatsList();
}
