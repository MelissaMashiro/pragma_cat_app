import 'package:dartz/dartz.dart';

import '../../entities/cat.dart';
import '../../entities/failure.dart';
import '../../repositories/cat_app_repository.dart';
import '../use_case.dart';

class CatsListUseCase extends UseCase<List<Cat>> {
  CatsListUseCase({
    required CatAppRepository catAppRepository,
  }) : _catAppRepository = catAppRepository;

  final CatAppRepository _catAppRepository;

  @override
  Future<Either<Failure, List<Cat>>> call(
      {required Map<String, dynamic> arguments}) async {
    return await _catAppRepository.getCatsList();
  }
}
