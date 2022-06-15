import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import 'package:wasalny/business_logic/cubit/maps/maps_cubit.dart';
import 'package:wasalny/styles/colors.dart';

import '../../data/models/address_model.dart';
import '../../data/models/prediction_model.dart';
import '../../shared/functions.dart';
import 'progress_dialog.dart';

class PredictionTile extends StatelessWidget {
  final PredictionModel prediction;
  PredictionTile({required this.prediction});

  void setPickupAddress(String placeID, context) async {
    final sessionToken = Uuid().v4();

    MapsCubit.get(context).updateDestinationAddress(placeID, sessionToken);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<MapsCubit, MapsState>(
        listenWhen: (previous, current) {
          return previous != current;
        },
        listener: (context, state) {
          if (state is Loading) {
            showProgressIndicator(context);

          }
          if (state is PlaceLocationLoaded) {
            Navigator.pop(context);
            Navigator.pop(context, 'getDirection');
          }
        },
        child: TextButton(
          onPressed: () {
            setPickupAddress(prediction.placeId!, context);
          },
          child: Container(
            child: Column(
              children: <Widget>[
                
                Row(
                  children: <Widget>[
                    Icon(
                      Icons.location_on_outlined,
                      color: MyColors.dimText,
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            prediction.mainText!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Text(
                            prediction.secondaryText!,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 12, color: MyColors.dimText),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
             
              ],
            ),
          ),
        ));
  }
}
