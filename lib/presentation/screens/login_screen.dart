// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasalny/presentation/widgets/phoneFormField.dart';

import '../../business_logic/cubit/phone_auth/phone_auth_cubit.dart';
import '../../shared/constants.dart';
import '../../shared/functions.dart';
import '../widgets/submit_button.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();
  late String phoneNumber;

  Future<void> _register(BuildContext context) async {
    if (!_phoneFormKey.currentState!.validate()) {
      Navigator.pop(context);
      return;
    } else {
      Navigator.pop(context);
      _phoneFormKey.currentState!.save();
      PhoneAuthCubit.get(context).submitPhoneNumber(phoneNumber);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PhoneAuthCubit, PhoneAuthState>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is Loading) {
            showProgressIndicator(context);
          }

          if (state is PhoneNumberSubmited) {
            Navigator.pop(context);
            Navigator.of(context).pushNamed(otpScreen, arguments: phoneNumber);
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
        child: SafeArea(
            child: Scaffold(
          body: Form(
            key: _phoneFormKey,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Enter your mobile number",
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
                      child: Text(
                        'Please enter your phone number to verify your account.',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 80,
                    ),
                    PhoneFormField(
                      onSave: (value) {
                        phoneNumber = value!;
                      },
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    SubmitButton(
                      text: 'Next',
                      onPress: () {
                        showProgressIndicator(context);
                        _register(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        )));
  }
}
