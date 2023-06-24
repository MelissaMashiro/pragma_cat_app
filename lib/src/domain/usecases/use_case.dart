
import 'package:dartz/dartz.dart';

import '../entities/failure.dart';

abstract class UseCase<Success> {
  Future<Either<Failure, Success>> call({
    required Map<String, dynamic> arguments,
  });
}