// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'package:wasalny/business_logic/cubit/maps/maps_cubit.dart';

import 'package:wasalny/shared/constants.dart';
import '../../data/models/address_model.dart';
import '../../data/models/user_model.dart';

import '../../styles/colors.dart';

import '../widgets/my_divider.dart';
import '../widgets/my_drawer.dart';

class HomeScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();
  double mapBottomPadding = (Platform.isIOS) ? 290 : 280;
  double searchSheetHeight = (Platform.isIOS) ? 320 : 275;
  UserModel? user;
  static AddressModel? currentAddress;
  Completer<GoogleMapController> _mapController = Completer();

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(currentAddress!.latitude!, currentAddress!.longitude!),
    tilt: 0.0,
    zoom: 14.4746,
  );

  Set<Marker> markers = Set();

  List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  Set<Marker> _Markers = {};
  Set<Circle> _Circles = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: MyDrawer(),
      body: Stack(fit: StackFit.expand, children: [
        BlocBuilder<MapsCubit, MapsState>(
            buildWhen: (previous, current) => current is CurrentAddressLoaded,
            builder: (context, state) {
              if (state is CurrentAddressLoaded) {
                currentAddress = (state).address;
              }

              return currentAddress != null
                  ? GoogleMap(
                      padding: EdgeInsets.only(bottom: mapBottomPadding),
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      zoomControlsEnabled: true,
                      myLocationButtonEnabled: true,
                      markers: markers,
                      initialCameraPosition: _myCurrentLocationCameraPosition,
                      onMapCreated: (GoogleMapController controller) {
                        _mapController.complete(controller);
                      },
                    )
                  : Center(
                      child: Container(
                        child: CircularProgressIndicator(
                          color: MyColors.blue,
                        ),
                      ),
                    );
            }),
        Positioned(
          top: 44,
          left: 20,
          child: GestureDetector(
            onTap: () {
              scaffoldKey.currentState!.openDrawer();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black26,
                        blurRadius: 5.0,
                        spreadRadius: 0.5,
                        offset: Offset(
                          0.7,
                          0.7,
                        ))
                  ]),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: 20,
                child: Icon(
                  Icons.menu,
                  color: Colors.black87,
                ),
              ),
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: AnimatedSize(
            // vsync: this,
            duration: new Duration(milliseconds: 150),
            curve: Curves.easeIn,
            child: Container(
              height: searchSheetHeight,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15),
                      topRight: Radius.circular(15)),
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
                        var response =
                            await Navigator.of(context).pushNamed(searchScreen);

                        if (response == 'getDirection') {
                          //  showDetailSheet();
                        }
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
                                color: Colors.blueAccent,
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
                          color: MyColors.dimText,
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
                                color: MyColors.dimText,
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
                          color: MyColors.dimText,
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
                                color: MyColors.dimText,
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
          ),
        ),
        // buildFloatingSearchBar()
      ]),
      //   floatingActionButton: Container(
      //     width: 40,
      //     margin: EdgeInsets.fromLTRB(0, 0, 8, 10),
      //     child: FloatingActionButton(
      //       backgroundColor: Colors.white,
      //       onPressed: _goToMyCurrentLocation,
      //       child: Icon(
      //         Icons.my_location_sharp,
      //         color: MyColors.grey,
      //         // size: 35,
      //       ),
      //     ),
      //   ),
    );
  }
}
