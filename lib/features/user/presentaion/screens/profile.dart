// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/functions.dart';
import '../../../../core/widgets/custom_text_form_field.dart';
import '../../domain/entities/user.dart';
import '../cubit/user/user_cubit.dart';
import '../widgets/image_picker_field.dart';
import '../../../../core/widgets/submit_button.dart';

class ProfileScreen extends StatelessWidget {
  final GlobalKey<FormState> _userFormKey = GlobalKey();

  User? user;
  File? userImage;
  void pickImage(File? image) {
    userImage = image;
  }

  Future<void> _saveUserData(BuildContext context) async {
    if (!_userFormKey.currentState!.validate()) {
      return;
    } else {
      _userFormKey.currentState!.save();
      if (user != UserCubit.get(context).currentUser) {
        print('change..............');
        if (userImage != null) {
          UserCubit.get(context).uploadImage(userImage!);
        } else {
          UserCubit.get(context).saveUserData(user!);
        }
      } else {
        print('no change..............');
        Navigator.of(context).pushReplacementNamed(Routes.homeScreenRoute);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    user = UserCubit.get(context).currentUser;

    return BlocConsumer<UserCubit, UserState>(listenWhen: (previous, current) {
      return previous != current;
    }, listener: (context, state) {
      if (state is Loading) {
        Functions.showProgressIndicator(context);
      }

      if (state is ImageUploaded) {
        user!.imageUrl = (state).url;
        UserCubit.get(context).saveUserData(user!);
      }

      if (state is UserDataSaved) {
        Navigator.of(context).pushReplacementNamed(Routes.homeScreenRoute);
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
    }, buildWhen: (previous, current) {
      return false;
    }, builder: (context, state) {
      return SafeArea(
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
      );
    });
  }
}
