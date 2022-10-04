import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasalny/features/user/presentaion/cubit/user/user_cubit.dart';

import '../../../../../../core/utils/assets_manager.dart';
import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/constants.dart';
import '../../../user/presentaion/cubit/phone_auth/phone_auth_cubit.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Timer _timer;

  _goNext() async {
    PhoneAuthCubit.get(context).checkAuthenticaion();
  }

  _startDelay() {
    _timer =
        Timer(const Duration(seconds: Constants.splashDelay), () => _goNext());
  }

  @override
  void initState() {
    super.initState();
    _startDelay();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
          listenWhen: (previous, current) {
        return previous != current;
      }, listener: (context, state) {
        if (state is AuthLoading) {
          // Functions.showProgressIndicator(context);
        } else if (state is Authenticated) {
          UserCubit.get(context).currentUser = (state).user;
          UserCubit.get(context).loadUserData();
        } else if (state is Unauthenticated) {
          Navigator.pushReplacementNamed(context, Routes.loginScreenRoute);
        }
      }, buildWhen: (previous, current) {
        return false;
      }, builder: (context, state) {
        return Center(
          child: Image.asset(ImgAssets.logo),
        );
      }),
      BlocConsumer<UserCubit, UserState>(listenWhen: (previous, current) {
        return previous != current;
      }, listener: (context, state) {
        print(state);
        if (state is UserDataLoaded) {
          Navigator.pushReplacementNamed(
            context,
            Routes.homeScreenRoute,
          );
        } else {
          Navigator.pushReplacementNamed(
            context,
            Routes.profileScreenRoute,
          );
        }
      }, buildWhen: (previous, current) {
        return false;
      }, builder: (context, state) {
        return Container();
      })
    ]));
  }
}
