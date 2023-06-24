part of 'cats_list_bloc.dart';

@freezed
class CatsListState with _$CatsListState {
  const factory CatsListState.loadInProgress() = _LoadInProgress;
  const factory CatsListState.completed(List<Cat> catsList) = _Completed;
  const factory CatsListState.error() = _Error;
  const factory CatsListState.initial() = _Initial;
  const factory CatsListState.loading() = _Loading;
}