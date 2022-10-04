import 'dart:io';

import 'package:flutter/material.dart';
import 'package:wasalny/features/maps/presentation/cubit/maps/maps_cubit.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/app_colors.dart';
import 'my_divider.dart';

class SearchSheet extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,

        child: Container(
          height: (Platform.isIOS) ? 340 : 320,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15), topRight: Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black26,
                    blurRadius: 15.0,
                    spreadRadius: 0.5,
                    offset: Offset(
                      0.7,
                      0.7,
                    ))
              ]),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 5,
                ),
                Text(
                  'Nice to see you!',
                  style: TextStyle(fontSize: 10),
                ),
                Text(
                  'Where are you going?',
                  style: TextStyle(fontSize: 18, fontFamily: 'Brand-Bold'),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () async {

                     await Navigator.of(context)
                        .pushNamed(Routes.searchScreenRoute);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(4),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              blurRadius: 5.0,
                              spreadRadius: 0.5,
                              offset: Offset(
                                0.7,
                                0.7,
                              ))
                        ]),
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.search,
                            color: AppColors.blue,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text('Search Destination'),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 22,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.home_outlined,
                      color: AppColors.dimText,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Add Home'),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Your residential address',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.dimText,
                          ),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                MyDivider(),
                SizedBox(
                  height: 16,
                ),
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.work_outline,
                      color: AppColors.dimText,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Add Work'),
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Your office address',
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.dimText,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
     
    );
  }
}
