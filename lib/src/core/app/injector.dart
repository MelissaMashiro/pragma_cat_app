import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:logging/logging.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import '../../data/datasources/local/cat_app_local_datasource.dart';
import '../../data/datasources/remote/cat_app_remote_datasource.dart';
import '../../data/models/json/json_config.dart';
import '../../data/models/network/network_client.dart';
import '../../data/models/network/network_info.dart';
import '../../data/repositories/cat_app_repository_impl.dart';
import '../../domain/entities/config.dart';
import '../../domain/usecases/cat_list/cats_list_use_case.dart';
import '../../presentation/features/catsList/bloc/cats_list/cats_list_bloc.dart';
import '../core.dart';

abstract class Injector {
  Stream<bool> get initializationStream;

  CatsListBloc get soccerboardBloc;

  GlobalKey<NavigatorState> get navigatorKey;

  Future<void> initialize();

  void dispose();

  bool isInitialized();
}

class DefaultInjector implements Injector {
  static final Logger _logger = Logger('DefaultInjector');

  final StreamController<bool> _initializationStreamController =
      StreamController<bool>.broadcast();
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();
  late Config _config;
  late Database _database;
  late CatsListUseCase _liveMatchsListUseCase;
  bool _initialized = false;

  @override
  GlobalKey<NavigatorState> get navigatorKey => _navigatorKey;

  @override
  Stream<bool> get initializationStream =>
      _initializationStreamController.stream;

  @override
  CatsListBloc get soccerboardBloc => CatsListBloc(
        catsListUseCase: _liveMatchsListUseCase,
      );

  @override
  void dispose() {
    _logger.finest('Disposing DefaultInjector…');
    _initialized = false;
    _initializationStreamController.add(_initialized);
    _initializationStreamController.close();
  }

  @override
  Future<void> initialize() async {
    if (!isInitialized()) {
      _logger.finest('Loading configuration…');
      final configJson = await rootBundle.loadString(
        Constants.path,
      );

      _config = JsonConfig.fromDynamic(
        json.decode(configJson),
      );

      final appDocumentDir = await getApplicationDocumentsDirectory();
      final dbPath = join(appDocumentDir.path, _config.databaseFileName);
      _database = await databaseFactoryIo.openDatabase(dbPath);

      final networkClient = NetworkClient(apiKey: _config.apiKey);
      final networkInfo = NetworkInfoImpl(Connectivity());

      _logger.finest('Creating repositories…');

      final soccerboardRemoteDataSource = CatAppRemoteDatasourceImpl(
        apikey: _config.apiKey,
        host: _config.host,
        endpoints: _config.endpoints,
        networkClient: networkClient,
      );

      final soccerboardLocalDataSource =
          CatAppLocalDatasourceImpl(database: _database);

      final soccerboardRepository = CatAppRepositoryImpl(
        networkInfo: networkInfo,
        catAppLocalDataSource: soccerboardLocalDataSource,
        catAppRemoteDataSource: soccerboardRemoteDataSource,
      );

      _liveMatchsListUseCase = CatsListUseCase(
        catAppRepository: soccerboardRepository,
      );

      _initialized = true;
      _logger.finest('Initialization completed');
      _initializationStreamController.add(_initialized);
    }
  }

  @override
  bool isInitialized() => _initialized;
}
