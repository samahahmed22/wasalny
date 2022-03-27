import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasalny/business_logic/cubit/phone_auth/phone_auth_cubit.dart';

import '../../constants/strings.dart';
import '../widgets/submit_button.dart';

class HomeScreen extends StatelessWidget {
  PhoneAuthCubit phoneAuthCubit = PhoneAuthCubit();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20),
          child: BlocProvider<PhoneAuthCubit>(
            create: (context) => phoneAuthCubit,
            child: SubmitButton(
              text: 'Logout',
              onPress: () async {
                await phoneAuthCubit.logOut();
                Navigator.of(context).pushReplacementNamed(loginScreen);
              },
            ),
          ),
        ),
      ),
    );
  }
}
