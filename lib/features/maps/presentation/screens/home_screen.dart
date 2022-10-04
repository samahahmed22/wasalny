// ignore_for_file: prefer_const_constructors
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasalny/features/maps/domain/entities/direction_details.dart';
import 'package:wasalny/features/maps/presentation/widgets/menuButton.dart';
import 'package:wasalny/features/maps/presentation/widgets/requestSheet.dart';
import 'package:wasalny/features/maps/presentation/widgets/rideDetailsSheet.dart';
import 'package:wasalny/features/maps/presentation/widgets/search_sheet.dart';

import '../../../../config/routes/app_routes.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../../core/widgets/error_widget.dart' as error;

import '../../../../core/utils/app_colors.dart';

import '../cubit/maps/maps_cubit.dart';

import '../widgets/my_drawer.dart';
import '../../domain/entities/address.dart';


class HomeScreen extends StatelessWidget {
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  double mapBottomPadding = (Platform.isAndroid) ? 390 : 310;

  static Address? currentAddress;
  static Address? pickupAddress;
  static Address? destinationAddress;
  DirectionDetails? directionDetails;

  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition googlePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static final CameraPosition _myCurrentLocationCameraPosition = CameraPosition(
    bearing: 0.0,
    target: LatLng(currentAddress!.latitude, currentAddress!.longitude),
    tilt: 0.0,
    zoom: 14.4746,
  );

  List<LatLng> polylineCoordinates = [];
  Set<Polyline> _polylines = {};
  Set<Marker> _markers = {};
  Set<Circle> _circles = {};
  LatLngBounds? bounds;

  Future<void> putDirectionsOnMap(BuildContext context) async {
    resetApp();
    polylineCoordinates = directionDetails!.polylinePoints
        .map((e) => LatLng(e.latitude, e.longitude))
        .toList();

    Polyline polyline = Polyline(
      polylineId: const PolylineId('my_polyline'),
      color: Colors.blue,
      width: 4,
      points: polylineCoordinates,
      jointType: JointType.round,
      startCap: Cap.roundCap,
      endCap: Cap.roundCap,
      geodesic: true,
    );

    _polylines.add(polyline);

    // make polyline to fit into the map

    pickupAddress = MapsCubit.get(context).pickupAddress;
    destinationAddress = MapsCubit.get(context).destinationAddress;

    LatLng pickupLatLng =
        LatLng(pickupAddress!.latitude, pickupAddress!.longitude);
    LatLng destinationLatLng =
        LatLng(destinationAddress!.latitude, destinationAddress!.longitude);

    if (pickupLatLng.latitude > destinationLatLng.latitude &&
        pickupLatLng.longitude > destinationLatLng.longitude) {
      bounds =
          LatLngBounds(southwest: destinationLatLng, northeast: pickupLatLng);
    } else if (pickupLatLng.longitude > destinationLatLng.longitude) {
      bounds = LatLngBounds(
          southwest: LatLng(pickupLatLng.latitude, destinationLatLng.longitude),
          northeast:
              LatLng(destinationLatLng.latitude, pickupLatLng.longitude));
    } else if (pickupLatLng.latitude > destinationLatLng.latitude) {
      bounds = LatLngBounds(
        southwest: LatLng(destinationLatLng.latitude, pickupLatLng.longitude),
        northeast: LatLng(pickupLatLng.latitude, destinationLatLng.longitude),
      );
    } else {
      bounds =
          LatLngBounds(southwest: pickupLatLng, northeast: destinationLatLng);
    }

    Marker pickupMarker = Marker(
      markerId: MarkerId('pickup'),
      position: pickupLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      infoWindow:
          InfoWindow(title: pickupAddress!.placeName, snippet: 'My Location'),
    );

    Marker destinationMarker = Marker(
      markerId: MarkerId('destination'),
      position: destinationLatLng,
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
      infoWindow: InfoWindow(
          title: destinationAddress!.placeName, snippet: 'Destination'),
    );

    _markers.add(pickupMarker);
    _markers.add(destinationMarker);

    Circle pickupCircle = Circle(
      circleId: CircleId('pickup'),
      strokeColor: Colors.green,
      strokeWidth: 3,
      radius: 12,
      center: pickupLatLng,
      fillColor: AppColors.colorGreen,
    );

    Circle destinationCircle = Circle(
      circleId: CircleId('destination'),
      strokeColor: AppColors.colorAccentPurple,
      strokeWidth: 3,
      radius: 12,
      center: destinationLatLng,
      fillColor: AppColors.colorAccentPurple,
    );

    _circles.add(pickupCircle);
    _circles.add(destinationCircle);
  }

  resetApp() {
    _polylines.clear();
    _markers.clear();
    _circles.clear();

    // drawerCanOpen = true;

    //     status = '';
    //     driverFullName = '';
    //     driverPhoneNumber = '';
    //     driverCarDetails = '';
    //     tripStatusDisplay = 'Driver is Arriving';

    //  setupPositionLocator();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: MyDrawer(),
      body: Stack(fit: StackFit.expand, children: [
        BlocConsumer<MapsCubit, MapsState>(
            listener: (context, state) {
              if (state is CurrentAddressLoaded) {
                currentAddress = (state).address;
              } else if (state is DirectionDetailsLoaded) {
                directionDetails = (state).directionDetails;
                putDirectionsOnMap(context);
                mapBottomPadding = (Platform.isAndroid) ? 270 : 230;
              } else if (state is ResetApp) {
                resetApp();
              }
            },
            buildWhen: (previous, current) => previous != current,
            builder: (context, state) {
              if (state is Loading) {
                return LoadingWidget();
              } else if (state is ErrorOccurred) {
                return error.ErrorWidget();
              } else {
                return GoogleMap(
                  padding: EdgeInsets.only(bottom: mapBottomPadding),
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  zoomGesturesEnabled: true,
                  zoomControlsEnabled: true,
                  myLocationButtonEnabled: true,
                  polylines: _polylines,
                  markers: _markers,
                  circles: _circles,
                  initialCameraPosition: _myCurrentLocationCameraPosition,
                  onMapCreated: (GoogleMapController controller) {
                    if (!_controller.isCompleted) {
                      _controller.complete(controller);
                    }

                    if (bounds != null) {
                      controller.animateCamera(
                          CameraUpdate.newLatLngBounds(bounds!, 70));
                    }
                  },
                );
              }
            }),
        BlocBuilder<MapsCubit, MapsState>(

            // buildWhen: (previous, current) => current is DirectionDetailsLoaded,
            builder: (context, state) {
          return directionDetails == null
              ? MenuButton(
                  icon: Icons.menu,
                  onTap: () {
                    scaffoldKey.currentState!.openDrawer();
                  },
                )
              : MenuButton(
                  icon: Icons.arrow_back,
                  onTap: () {
                    Navigator.of(context).pushNamed(Routes.searchScreenRoute);
                  },
                );
        }),
        BlocBuilder<MapsCubit, MapsState>(
            // buildWhen: (previous, current) => current is DirectionDetailsLoaded,
            builder: (context, state) {
          if (state is DirectionDetailsLoaded) {
            return RideDetailsSheet(tripDirectionDetails: directionDetails!);
          } else if (state is RequestingARide) {
            return RequestSheet();
          } else {
            return SearchSheet();
          }
        }),
      ]),
    );
  }
}
