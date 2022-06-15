// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:wasalny/data/models/user_model.dart';
import 'package:wasalny/presentation/widgets/custom_text_form_field.dart';
import 'package:wasalny/shared/constants.dart';

import '../../business_logic/cubit/user/user_cubit.dart';
import '../../shared/functions.dart';
import '../widgets/image_picker_field.dart';
import '../widgets/submit_button.dart';

class EditAccountScreen extends StatelessWidget {
  final GlobalKey<FormState> _userFormKey = GlobalKey();

  UserModel? user;
  File? userImage;
  void pickImage(File? image) {
    userImage = image;
  }

  Future<void> _saveUserData(BuildContext context) async {
    if (!_userFormKey.currentState!.validate()) {
      return;
    } else {
      _userFormKey.currentState!.save();

      BlocProvider.of<UserCubit>(context).saveUserData(user!, userImage);
    }
  }

  @override
  Widget build(BuildContext context) {
    user = UserCubit.get(context).user;

    return BlocListener<UserCubit, UserState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is Loading) {
          showProgressIndicator(context);
        }

        if (state is UserDataSaved) {
          Navigator.of(context).pushReplacementNamed(homeScreen);
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
          appBar: AppBar(title: Text('Edit profile')),
          body: Form(
            key: _userFormKey,
            child: SingleChildScrollView(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 80),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    // Text('Edit Account'),
                    ImagePickerField(pickImage, user!.imageUrl),
                    SizedBox(height: 48),

                    CustomTextFormField(
                      initialValue: user!.firstName,
                      label: 'First Name',
                      onSave: (value) {
                        user!.firstName = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your first name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    CustomTextFormField(
                      initialValue: user!.lastName,
                      label: 'Last Name',
                      onSave: (value) {
                        user!.lastName = value!;
                      },
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your last name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 15),

                    CustomTextFormField(
                      initialValue: user!.email,
                      label: 'Email',
                      onSave: (value) {
                        user!.email = value!;
                      },
                      validator: (value) {},
                    ),

                    SizedBox(height: 48),

                    SubmitButton(
                      text: 'Done',
                      onPress: () {
                        _saveUserData(context);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
