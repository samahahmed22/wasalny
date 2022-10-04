// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:wasalny/features/user/presentaion/cubit/user/user_cubit.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/widgets/submit_button.dart';

import '../../../../core/utils/app_colors.dart';
import '../../../../core/utils/functions.dart';
import '../cubit/phone_auth/phone_auth_cubit.dart';

class OtpScreen extends StatelessWidget {
  final phoneNumber;
  OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);
  late String otpCode;

  void _login(BuildContext context) {
    PhoneAuthCubit.get(context).submitOTP(otpCode);
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PhoneAuthCubit, PhoneAuthState>(
        listenWhen: (previous, current) {
      return previous != current;
    }, listener: (context, state) {
      if (state is AuthLoading) {
        Functions.showProgressIndicator(context);
      }

      if (state is Authenticated) {
        UserCubit.get(context).currentUser = (state).user;
        UserCubit.get(context).loadUserData();
        Navigator.of(context).pushReplacementNamed(Routes.profileScreenRoute);
      }

      if (state is AuthErrorOccurred) {
        //Navigator.pop(context);
        String errorMsg = (state).errorMsg;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMsg),
            backgroundColor: Colors.black,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }, buildWhen: (previous, current) {
      return false;
    }, builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
            child: SingleChildScrollView(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Verify your phone number',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      child: RichText(
                        text: TextSpan(
                          text: 'Enter your 6 digit code numbers sent to ',
                          style: TextStyle(
                              color: Colors.black, fontSize: 18, height: 1.4),
                          children: <TextSpan>[
                            TextSpan(
                              text: '$phoneNumber',
                              style: TextStyle(color: AppColors.blue),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    PinCodeTextField(
                      appContext: context,
                      autoFocus: true,
                      cursorColor: Colors.black,
                      keyboardType: TextInputType.number,
                      length: 6,
                      obscureText: false,
                      animationType: AnimationType.scale,
                      pinTheme: PinTheme(
                        shape: PinCodeFieldShape.box,
                        borderRadius: BorderRadius.circular(5),
                        fieldHeight: 50,
                        fieldWidth: 40,
                        borderWidth: 1,
                        activeColor: AppColors.blue,
                        inactiveColor: AppColors.blue,
                        inactiveFillColor: Colors.white,
                        activeFillColor: AppColors.lightBlue,
                        selectedColor: AppColors.blue,
                        selectedFillColor: Colors.white,
                      ),
                      animationDuration: Duration(milliseconds: 300),
                      backgroundColor: Colors.white,
                      enableActiveFill: true,
                      onCompleted: (submitedCode) {
                        otpCode = submitedCode;
                        print("Completed");
                      },
                      onChanged: (value) {
                        print(value);
                      },
                    ),
                    SizedBox(
                      height: 60,
                    ),
                    SubmitButton(
                      text: 'Verify',
                      onPress: () {
                        Functions.showProgressIndicator(context);
                        _login(context);
                      },
                    ),
                  ]),
            ),
          ),
        ),
      );
    });
  }
}
