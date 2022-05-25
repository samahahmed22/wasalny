part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class Loading extends UserState {}

class UserDataLoaded extends UserState {
  final UserModel user;
  UserDataLoaded({required this.user});
}
class UserDataNotLoaded extends UserState {
}

class UserDataSaved extends UserState {}

class ErrorOccurred extends UserState {
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});
}
