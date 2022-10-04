import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:wasalny/core/utils/app_colors.dart';

import '../../domain/entities/prediction.dart';
import '../cubit/maps/maps_cubit.dart';


class PredictionTile extends StatelessWidget {
  final Prediction prediction;
  PredictionTile({required this.prediction});

  void setPickupAddress(String placeID, context) async {
    final sessionToken = Uuid().v4();

    MapsCubit.get(context).getAddressDetails(placeID, sessionToken);
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
          onPressed: () {
            setPickupAddress(prediction.placeId, context);
          },
          child: Container(
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on_outlined,
                      color: AppColors.dimText,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            prediction.mainText,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            prediction.secondaryText,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12, color: AppColors.dimText),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
  }
}
