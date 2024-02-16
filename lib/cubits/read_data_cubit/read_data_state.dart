part of 'read_data_cubit.dart';


sealed class ReadDataState {}

final class ReadDataInitial extends ReadDataState {}

final class ReadDataLoading extends ReadDataState {}

final class ReadDataSuccess extends ReadDataState {
  final List<WordModel> words;
  ReadDataSuccess({required this.words});
}

final class ReadDataFailure extends ReadDataState {
  final String eMessage;

  ReadDataFailure({required this.eMessage});
}
