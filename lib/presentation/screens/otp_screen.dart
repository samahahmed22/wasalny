// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../constants/my_colors.dart';
import '../widgets/submit_button.dart';

class OtpScreen extends StatelessWidget {
  final phoneNumber = '123';
  //  OtpScreen({Key? key, required this.phoneNumber}) : super(key: key);
  @override
  Widget build(BuildContext context) {
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
                            style: TextStyle(color: MyColors.blue),
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
                      activeColor: MyColors.blue,
                      inactiveColor: MyColors.blue,
                      inactiveFillColor: Colors.white,
                      activeFillColor: MyColors.lightBlue,
                      selectedColor: MyColors.blue,
                      selectedFillColor: Colors.white,
                    ),
                    animationDuration: Duration(milliseconds: 300),
                    backgroundColor: Colors.white,
                    enableActiveFill: true,
                    onCompleted: (submitedCode) {
                      // otpCode = submitedCode;
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
                    onPress: () {},
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
