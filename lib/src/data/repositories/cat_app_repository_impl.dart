import 'package:dartz/dartz.dart';

import '../../domain/entities/cache_exception.dart';
import '../../domain/entities/cat.dart';
import '../../domain/entities/failure.dart';
import '../../domain/entities/server_exception.dart';
import '../../domain/repositories/cat_app_repository.dart';
import '../datasources/local/cat_app_local_datasource.dart';
import '../datasources/remote/cat_app_remote_datasource.dart';
import '../models/network/network_info.dart';

class CatAppRepositoryImpl implements CatAppRepository {
  final NetworkInfo _networkInfo;
  final CatAppLocalDatasource _catAppLocalDataSource;
  final CatAppRemoteDatasource _catAppRemoteDataSource;

  CatAppRepositoryImpl({
    required catAppRemoteDataSource,
    required catAppLocalDataSource,
    required networkInfo,
  })  : _networkInfo = networkInfo,
        _catAppLocalDataSource = catAppLocalDataSource,
        _catAppRemoteDataSource = catAppRemoteDataSource;

  @override
  Future<Either<Failure, List<Cat>>> getCatsList() async {
    if (await _networkInfo.isConnected) {
      try {
        final remoteCatsList = await _catAppRemoteDataSource.getCatsList();

        // ignore: avoid_function_literals_in_foreach_calls
        remoteCatsList.forEach((cat) async {
          await _catAppLocalDataSource.store(cat);
        });

        return Right(remoteCatsList);
      } on ServerException catch (se) {
        return Left(Failure(
          code: se.code,
          message: se.message,
        ));
      } on Exception catch (_) {
        return Left(
          Failure(message: 'Unknown Error'),
        );
      }
    } else {
      try {
        final localCatsList = await _catAppLocalDataSource.getSavedCatsList();
        return Right(localCatsList);
      } on CacheException {
        return Left(
          Failure(message: 'Error trayendo la Informacion del cache '),
        );
      } on Exception catch (_) {
        return Left(
          Failure(message: 'Unknown Error'),
        );
      }
    }
  }
}
