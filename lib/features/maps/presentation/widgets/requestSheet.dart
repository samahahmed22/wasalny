import 'dart:io';

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:wasalny/core/utils/app_colors.dart';

class RequestSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 15.0, // soften the shadow
              spreadRadius: 0.5, //extend the shadow
              offset: Offset(
                0.7, // Move to right 10  horizontally
                0.7, // Move to bottom 10 Vertically
              ),
            )
          ],
        ),
        height: (Platform.isAndroid) ? 250 : 230,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 10,
              ),
              SizedBox(
                width: double.infinity,
                child: TextLiquidFill(
                  text: 'Requesting a Ride...',
                  waveColor: AppColors.colorTextSemiLight,
                  boxBackgroundColor: Colors.white,
                  textStyle: TextStyle(
                      color: AppColors.colorText,
                      fontSize: 22.0,
                    ),
                  boxHeight: 40.0,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              GestureDetector(
                onTap: () {
                  // cancelRequest();
                  // resetApp();
                },
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    border: Border.all(
                        width: 1.0, color: AppColors.colorLightGrayFair),
                  ),
                  child: Icon(
                    Icons.close,
                    size: 25,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                child: Text(
                  'Cancel ride',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 12),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
