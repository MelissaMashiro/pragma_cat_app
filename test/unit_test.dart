import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pragma_cat_app/src/domain/entities/cat.dart';
import 'package:pragma_cat_app/src/domain/repositories/cat_app_repository.dart';
import 'package:pragma_cat_app/src/domain/usecases/cat_list/cats_list_use_case.dart';

class MockPostRepository extends Mock implements CatAppRepository {}

void main() {
  late CatsListUseCase catsListUseCase;

  late MockPostRepository mockRepository;

  setUp(() {
    mockRepository = MockPostRepository();

    catsListUseCase = CatsListUseCase(catAppRepository: mockRepository);
  });

  //CREANDO EL MOCK DE LA RESPUESTA:

  final catsListFromAPI = <Cat>[];

  test('Should get all cats list from API', () async {
    when(
      () => mockRepository.getCatsList(),
    ).thenAnswer(
      (_) async => Right(catsListFromAPI),
    );

    final result = await catsListUseCase(arguments: {});

    expect(
      result,
      Right(catsListFromAPI),
    );

    verify(
      () => mockRepository.getCatsList(),
    ).called(1);

    verifyNoMoreInteractions(mockRepository);
  });
}
