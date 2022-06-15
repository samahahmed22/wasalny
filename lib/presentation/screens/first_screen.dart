import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../shared/functions.dart';

import '../../business_logic/cubit/user/user_cubit.dart';
import '../../shared/constants.dart';

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    UserCubit.get(context).loadUserData();
    return BlocListener<UserCubit, UserState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }

        if (state is UserDataLoaded) {
          Navigator.of(context).pushReplacementNamed(homeScreen);
        }
        if (state is UserDataNotLoaded) {
          Navigator.of(context).pushReplacementNamed(editAccountScreen);
        }

        if (state is ErrorOccurred) {
          Navigator.pop(context);
          String errorMsg = (state).errorMsg;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(errorMsg),
              backgroundColor: Colors.black,
              duration: Duration(seconds: 3),
            ),
          );
        }
      },
      child: Container(),
    );
  }
}
