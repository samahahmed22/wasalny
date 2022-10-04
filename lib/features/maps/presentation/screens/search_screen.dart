import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:wasalny/features/maps/presentation/widgets/search_bar.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../domain/entities/address.dart';
import '../../domain/entities/prediction.dart';
import '../cubit/maps/maps_cubit.dart';
import '../widgets/my_divider.dart';
import '../widgets/prediction_tile.dart';

enum SearchFor { pickup, destination }

class SearchScreen extends StatelessWidget {
  var pickupController = TextEditingController();
  var destinationController = TextEditingController();

  var focusDestination = FocusNode();
  var focusPickup = FocusNode();

  Address? currentAddress;
  Address? pickupAddress;
  Address? destinationAddress;

  List<Prediction> predictionList = [];

  bool isInit = false;

  SearchFor searchFor = SearchFor.destination;

  void setInit(BuildContext context) {
    if (!isInit) {
      FocusScope.of(context).requestFocus(focusDestination);
      currentAddress = MapsCubit.get(context).currentAddress;
      pickupAddress = MapsCubit.get(context).pickupAddress;
      destinationAddress = MapsCubit.get(context).destinationAddress;
      isInit = true;
    }
  }

  void getDirections(
      Address pickupAddress, Address destinationAddress, BuildContext context) {
    LatLng pickupLatLng =
        LatLng(pickupAddress.latitude, pickupAddress.longitude);
    LatLng destinationLatLng =
        LatLng(destinationAddress.latitude, destinationAddress.longitude);

    MapsCubit.get(context).getDirectionDetails(pickupLatLng, destinationLatLng);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    setInit(context);

    if (pickupAddress != null && pickupAddress != currentAddress) {
      pickupController.text = pickupAddress!.placeName;
    } else {
      pickupController.text = 'Current Location';
    }
    if (destinationAddress != null) {
      destinationController.text = destinationAddress!.placeName;
    }

    return Scaffold(
        body: BlocListener<MapsCubit, MapsState>(
      listenWhen: (previous, current) {
        return previous != current;
      },
      listener: (context, state) {
        if (state is PredictionsLoaded) {
          predictionList = (state).predictions;
        } else if (state is PredictionsReseted) {
          predictionList = [];
        } else if (state is AddressDetailsLoaded) {
          if (searchFor == SearchFor.pickup) {
            pickupAddress = (state).address;
            MapsCubit.get(context).setPickupAddress(pickupAddress!);
            if (destinationAddress != null) {
              getDirections(pickupAddress!, destinationAddress!, context);
            } else {
              pickupController.text = pickupAddress!.placeName;
              FocusScope.of(context).requestFocus(focusDestination);
              searchFor = SearchFor.destination;
            }
          } else if (searchFor == SearchFor.destination) {
            destinationAddress = (state).address;
            MapsCubit.get(context).setDestinationAddress(destinationAddress!);
            if (pickupAddress == null) {
              pickupAddress = currentAddress;
              MapsCubit.get(context).setPickupAddress(pickupAddress!);
            }
             getDirections(pickupAddress!, destinationAddress!, context);
          }
        }
      },
      child: Column(
        children: <Widget>[
          Container(
            // height: 300,
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 5.0,
                spreadRadius: 0.5,
                offset: Offset(
                  0.7,
                  0.7,
                ),
              ),
            ]),
            child: Padding(
              padding:
                  EdgeInsets.only(left: 24, top: 48, right: 24, bottom: 20),
              child: Column(
                children: <Widget>[
                  SizedBox(
                    height: 5,
                  ),
                  Stack(
                    children: <Widget>[
                      GestureDetector(
                          onTap: () {
                            MapsCubit.get(context).resetApp();
                            Navigator.pop(context);
                            
                          },
                          child: Icon(Icons.arrow_back)),
                      Center(
                        child: Text(
                          'Set Destination',
                          style:
                              TextStyle(fontSize: 20, fontFamily: 'Brand-Bold'),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 18,
                  ),
                  SearchBar(
                    controller: pickupController,
                    focusNode: focusPickup,
                    imageIcon: ImgAssets.pickIcon,
                    hint: 'Pickup Location',
                    onTap: () {
                      if (searchFor != SearchFor.pickup) {
                        if (destinationAddress == null) {
                          destinationController.text = '';
                        } else {
                          destinationController.text =
                              destinationAddress!.placeName;
                        }
                        if (pickupController.text == 'Current Location') {
                          pickupController.text = '';
                        }
                        MapsCubit.get(context).resetPredictions();
                        searchFor = SearchFor.pickup;
                      }
                    },
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SearchBar(
                    controller: destinationController,
                    focusNode: focusDestination,
                    imageIcon: ImgAssets.destIcon,
                    hint: 'Where to?',
                    onTap: () {
                      if (searchFor != SearchFor.destination) {
                        if (pickupAddress == null) {
                          pickupController.text = 'Current Location';
                        } else {
                          pickupController.text = pickupAddress!.placeName;
                        }
                        MapsCubit.get(context).resetPredictions();
                        searchFor = SearchFor.destination;
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          BlocBuilder<MapsCubit, MapsState>(
              buildWhen: (previous, current) => previous != current,
              builder: (context, state) {
                return (predictionList.length > 0)
                    ? Padding(
                        padding:
                            EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                        child: ListView.separated(
                          padding: EdgeInsets.all(0),
                          itemBuilder: (context, index) {
                            return PredictionTile(
                              prediction: predictionList[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              MyDivider(),
                          itemCount: predictionList.length,
                          shrinkWrap: true,
                          physics: ClampingScrollPhysics(),
                        ),
                      )
                    : Container();
              })
        ],
      ),
    ));
  }
}
