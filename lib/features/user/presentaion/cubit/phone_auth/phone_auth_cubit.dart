import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:wasalny/features/user/domain/usecases/get_current_user.dart';
import 'package:wasalny/features/user/domain/usecases/logout.dart';
import 'package:wasalny/features/user/domain/usecases/signIn.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../domain/entities/user.dart' as u;

part 'phone_auth_state.dart';

class PhoneAuthCubit extends Cubit<PhoneAuthState> {
  final SignInUsecase signInUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;
  final LogoutUsecase logoutUsecase;

  PhoneAuthCubit(
      {required this.signInUsecase,
      required this.getCurrentUserUsecase,
      required this.logoutUsecase})
      : super(PhoneAuthInitial());

  static PhoneAuthCubit get(context) => BlocProvider.of(context);

  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  late String verificationId;

  Future<void> submitPhoneNumber(String number) async {
    emit(AuthLoading());

    await _firebaseAuth.verifyPhoneNumber(
      phoneNumber: '+966$number',
      timeout: const Duration(seconds: 14),
      verificationCompleted: verificationCompleted,
      verificationFailed: verificationFailed,
      codeSent: codeSent,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void verificationCompleted(PhoneAuthCredential credential) async {
    print('verificationCompleted');
    await signIn(credential);
  }

  void verificationFailed(FirebaseAuthException error) async {
    emit(
        AuthErrorOccurred(errorMsg: 'verificationFailed :${error.toString()}'));
  }

  void codeSent(String verificationId, int? resendToken) {
    this.verificationId = verificationId;
    emit(PhoneNumberSubmited());
  }

  void codeAutoRetrievalTimeout(String verificationId) {
    emit(AuthErrorOccurred(errorMsg: 'codeAutoRetrievalTimeout'));
  }

  Future<void> submitOTP(String otpCode) async {
    print('.....................');
    print(otpCode);
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: this.verificationId, smsCode: otpCode);
    print('credential..........');
    print(credential);
    await signIn(credential);
  }

  Future<void> signIn(PhoneAuthCredential credential) async {
    print('.....................123');
    Either<Failure, u.User> response = await signInUsecase(credential);
    print(response);
    response.fold(
        (failure) =>
            emit(AuthErrorOccurred(errorMsg: _userFailureToMsg(failure))),
        (user) => emit(Authenticated(user: user)));
  }

  Future<void> checkAuthenticaion() async {
    emit(AuthLoading());
    Either<Failure, u.User> response = await getCurrentUserUsecase();

    response.fold((failure) => emit(Unauthenticated()),
        (user) => emit(Authenticated(user: user)));
  }

  Future<void> logOut() async {
    emit(AuthLoading());
    Either<Failure, Unit> response = await logoutUsecase();
    print(response);
    response.fold(
        (failure) =>
            emit(AuthErrorOccurred(errorMsg: _userFailureToMsg(failure))),
        (_) => emit(Unauthenticated()));
  }

  String _userFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      case OfflineFailure:
        return AppStrings.offlineFailure;

      default:
        return AppStrings.unexpectedError;
    }
  }
}
