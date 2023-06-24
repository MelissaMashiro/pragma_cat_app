import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import '../../../../../domain/entities/cat.dart';
import '../../../../../domain/usecases/cat_list/cats_list_use_case.dart';

part 'cats_list_state.dart';
part 'cats_list_event.dart';
part 'cats_list_bloc.freezed.dart';

class CatsListBloc extends Bloc<CatsListEvent,CatsListState>{
  
    final CatsListUseCase _catsListUseCase;

  CatsListBloc({
    required CatsListUseCase catsListUseCase,
  })  : _catsListUseCase = catsListUseCase,
        super(const CatsListState.initial()) {
    on<CatsListStarted>(_getLiveMatchs);
  }

  CatsListState get initialState => const CatsListState.initial();

  Future<void> _getLiveMatchs(event, emit) async {
    emit(const CatsListState.loading());

    final result = await _catsListUseCase.call(arguments: {});

    result.fold(
      (error) async {
        emit(const CatsListState.error());
      },
      (success) async {
        emit(CatsListState.completed(success));
      },
    );
  }
}
