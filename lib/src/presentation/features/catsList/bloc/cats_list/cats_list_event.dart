part of 'cats_list_bloc.dart';

@freezed
class CatsListEvent with _$CatsListEvent {
  const factory CatsListEvent.catsListStarted() = CatsListStarted;

}