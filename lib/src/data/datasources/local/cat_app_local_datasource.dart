import 'package:sembast/sembast.dart';

import '../../../domain/entities/cat.dart';

abstract class CatAppLocalDatasource {
  Future<List<Cat>> getSavedCatsList();

  Future<void> store(Cat cat);

  Future<void> update(Cat cat);
}

class CatAppLocalDatasourceImpl implements CatAppLocalDatasource {
  CatAppLocalDatasourceImpl({
    required Database database,
  }) : _database = database;

  final Database _database;
  final _catStore = stringMapStoreFactory.store(
    Cat.storeName,
  );

  @override
  Future<List<Cat>> getSavedCatsList() async {
    final snapshot = await _catStore.find(
      _database,
      finder: null,
    );

    return Cat.fromSavedDynamicList(snapshot);
  }

  @override
  Future<void> store(Cat cat) async {
    await _database.transaction(
      (txn) async => await _catStore.add(
        txn,
        cat.toJson(),
      ),
    );
  }

  @override
  Future<void> update(Cat cat) async {
    await _database.transaction(
      (transaction) async {
        await _catStore.update(
          transaction,
          cat.toJson(),
          finder: Finder(
            filter: Filter.equals(
              'id',
              cat.id,
            ),
          ),
        );
      },
    );
  }
}
