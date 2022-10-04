part of 'phone_auth_cubit.dart';

@immutable
abstract class PhoneAuthState {}

class PhoneAuthInitial extends PhoneAuthState {}

class AuthLoading extends PhoneAuthState {}

class AuthErrorOccurred extends PhoneAuthState {
  final String errorMsg;

  AuthErrorOccurred({required this.errorMsg});
}

class PhoneNumberSubmited extends PhoneAuthState {}

class PhoneOTPVerified extends PhoneAuthState {
  u.User user;
  PhoneOTPVerified({required this.user});
}

class LoggedOut extends PhoneAuthState {}

class Authenticated extends PhoneAuthState {
  u.User user;
  Authenticated({required this.user});
}

class Unauthenticated extends PhoneAuthState {}
