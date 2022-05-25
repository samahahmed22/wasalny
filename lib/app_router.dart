// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasalny/presentation/screens/edit_account_screen.dart';
import 'package:wasalny/presentation/screens/first_screen.dart';
import 'package:wasalny/presentation/screens/home_screen.dart';
import 'package:wasalny/presentation/screens/login_screen.dart';
import 'package:wasalny/presentation/screens/on_boarding_screen.dart';
import 'package:wasalny/presentation/screens/otp_screen.dart';

import 'business_logic/cubit/phone_auth/phone_auth_cubit.dart';

import 'business_logic/cubit/user/user_cubit.dart';
import '../../../shared/constants.dart';

class AppRouter {
  PhoneAuthCubit? phoneAuthCubit;
  UserCubit? userCubit;

  AppRouter() {
    phoneAuthCubit = PhoneAuthCubit();
    userCubit = UserCubit();
  }

  Route? generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case onBoardingScreen:
        return MaterialPageRoute(builder: (_) => OnBoardingScreen());

      case firstScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<UserCubit>.value(
                value: userCubit!, child: FirstScreen()));

      case homeScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<UserCubit>.value(
                value: userCubit!, child: HomeScreen()));

      case editAccountScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<UserCubit>.value(
                  value: userCubit!,
                  child: EditAccountScreen(),
                ));

      case loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: LoginScreen(),
          ),
        );

      case otpScreen:
        final phoneNumber = settings.arguments;
        return MaterialPageRoute(
          builder: (_) => BlocProvider<PhoneAuthCubit>.value(
            value: phoneAuthCubit!,
            child: OtpScreen(phoneNumber: phoneNumber),
          ),
        );
    }
  }
}
