// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:wasalny/constants/strings.dart';
import 'package:wasalny/presentation/widgets/phoneFormField.dart';

import '../../constants/my_colors.dart';
import '../widgets/submit_button.dart';

class LoginScreen extends StatelessWidget {
  final GlobalKey<FormState> _phoneFormKey = GlobalKey();
  late String phoneNumber;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white,
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
                      Navigator.pushNamed(context, otpScreen);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
