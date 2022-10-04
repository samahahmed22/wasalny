import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:wasalny/core/utils/app_colors.dart';
import 'package:wasalny/features/maps/presentation/cubit/maps/maps_cubit.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/submit_button.dart';
import '../../domain/entities/direction_details.dart';

class RideDetailsSheet extends StatelessWidget {
  DirectionDetails tripDirectionDetails;

  RideDetailsSheet({required this.tripDirectionDetails});

  static int estimateFares(DirectionDetails details) {
    // per km = $0.3,
    // per minute = $0.2,
    // base fare = $3,

    double baseFare = 3;
    double distanceFare = (details.distanceValue / 1000) * 0.3;
    double timeFare = (details.durationValue / 60) * 0.2;

    double totalFare = baseFare + distanceFare + timeFare;

    return totalFare.truncate();
  }

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
        height: (Platform.isAndroid) ? 250 : 265,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 18),
          child: Column(
            children: <Widget>[
              Container(
                width: double.infinity,
                color: AppColors.colorAccent1,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: <Widget>[
                      Image.asset(
                        ImgAssets.taxi,
                        height: 70,
                        width: 70,
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Taxi',
                            style: TextStyle(
                                fontSize: 18, fontFamily: 'Brand-Bold'),
                          ),
                          Text(
                            tripDirectionDetails.distanceText,
                            style: TextStyle(
                                fontSize: 16, color: AppColors.colorTextLight),
                          )
                        ],
                      ),
                      Expanded(child: Container()),
                      Text(
                        '\$${estimateFares(tripDirectionDetails)}',
                        style:
                            TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  children: <Widget>[
                    Icon(
                      FontAwesomeIcons.moneyBills,
                      size: 18,
                      color: AppColors.colorTextLight,
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Text('Cash'),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.colorTextLight,
                      size: 16,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 22,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: SubmitButton(
                  text: 'REQUEST CAB',
             
                  onPress: () {
                    MapsCubit.get(context).requestARide();
                    // setState(() {
                    //   appState = 'REQUESTING';
                    // });
                    // showRequestingSheet();

                    // availableDrivers = FireHelper.nearbyDriverList;

                    // findDriver();
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
