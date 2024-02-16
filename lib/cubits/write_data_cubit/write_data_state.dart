part of 'write_data_cubit.dart';

sealed class WriteDataState {}

final class WriteDataInitial extends WriteDataState {}

final class WriteDataLoading extends WriteDataState {}

final class WriteDataSuccess extends WriteDataState {}

final class WriteDataFailure extends WriteDataState {
  final String eMessage;

  WriteDataFailure({required this.eMessage});
}
