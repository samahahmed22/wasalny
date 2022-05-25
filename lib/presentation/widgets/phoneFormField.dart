import 'package:flutter/material.dart';

import '../../styles/colors.dart';
import 'custom_text_form_field.dart';

class PhoneFormField extends StatelessWidget {
  final Function(String?) onSave;

  PhoneFormField({
    required this.onSave,
  });

  String generateCountryFlag() {
    String countryCode = 'sa';

    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          // width: 110,
          padding: EdgeInsets.symmetric(horizontal: 5, vertical: 18),

          decoration: BoxDecoration(
            color: MyColors.lightGrey,
            border: Border.all(color: MyColors.lightGrey),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Text(
            generateCountryFlag() + ' +966',
            style: TextStyle(fontSize: 20, letterSpacing: 2.0),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          // flex: 2,
          child: Container(
            width: double.infinity,
            // padding: EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            // decoration: BoxDecoration(
            //   border: Border.all(color: MyColors.blue),
            //   borderRadius: BorderRadius.all(Radius.circular(6)),
            // ),
            child: CustomTextFormField(
              autofocus: true,
              keyboardType: TextInputType.phone,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter your phone number!';
                } else if (value.length < 9) {
                  return 'This phone number is invalid!';
                }
                return null;
              },
              onSave: onSave,
            ),
          ),
        ),
      ],
    );
  }
}
