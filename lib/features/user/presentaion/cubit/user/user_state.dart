part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class Loading extends UserState {}

class UserDataLoaded extends UserState {
  final User user;
  UserDataLoaded({required this.user});
}
class UserDataNotFound extends UserState {
}

class UserDataSaved extends UserState {}

class ImageUploaded extends UserState {
  String url;
  ImageUploaded(this. url);
}


class ErrorOccurred extends UserState {
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});
}
