import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasalny/core/helpers/location_helper.dart';

import '../../../../core/api/api_consumer.dart';
import '../../../../core/api/end_points.dart';
import '../../../../core/utils/constants.dart';
import '../models/address_model.dart';
import '../models/direction_details_model.dart';
import '../models/prediction_model.dart';

abstract class MapsRemoteDataSource {
  Future<AddressModel> getCurrentAddress();
  Future<List<PredictionModel>> fetchSuggestions(
      String place, String sessionToken);
  Future<AddressModel> getPlaceDetails(String placeId, String sessionToken);
  Future<DirectionDetailsModel> getDirections(LatLng start, LatLng destination);
}

class MapsRemoteDataSourceImpl implements MapsRemoteDataSource {
  ApiConsumer apiConsumer;
  LocationHelper locationHelper;

  MapsRemoteDataSourceImpl(
      {required this.apiConsumer, required this.locationHelper});

  @override
  Future<AddressModel> getCurrentAddress() async {
    final position = await getCurrentPosition();
    final coordinateAddress = await findCoordinateAddress(position);
    return AddressModel.fromCoordinateAdressJson(coordinateAddress);
  }

  Future<Position> getCurrentPosition() async {
    final response = await locationHelper.getCurrentLocation();
    return response;
  }

  Future<dynamic> findCoordinateAddress(Position position) async {
    final response = await apiConsumer.get(
      EndPoints.cordinateAddress,
      queryParameters: {
        'latlng': '${position.latitude},${position.longitude}',
        'key': Constants.googleAPIKey,
      },
    );
    return response;
  }

  @override
  Future<List<PredictionModel>> fetchSuggestions(
      String place, String sessionToken) async {
    final response = await apiConsumer.get(
      EndPoints.predictions,
      queryParameters: {
        'input': place,
        'key': Constants.googleAPIKey,
        'sessiontoken': sessionToken,
        'components': 'country:sa',
      },
    );

    return List<PredictionModel>.from(response["predictions"]
        .map((prediction) => PredictionModel.fromJson(prediction)));
  }

  @override
  Future<AddressModel> getPlaceDetails(
      String placeId, String sessionToken) async {
    final response = await apiConsumer.get(
      EndPoints.placeDetails,
      queryParameters: {
        'place_id': placeId,
        'key': Constants.googleAPIKey,
        'sessiontoken': sessionToken
      },
    );

    return AddressModel.fromPlaceDetailsJson(response);
  }

  @override
  // origin equals current location
  // destination equals searched for location
  Future<DirectionDetailsModel> getDirections(
      LatLng start, LatLng destination) async {
    final response = await apiConsumer.get(
      EndPoints.directions,
      queryParameters: {
        'origin': '${start.latitude},${start.longitude}',
        'destination': '${destination.latitude},${destination.longitude}',
        'mode': 'driving',
        'key': Constants.googleAPIKey,
      },
    );
    return DirectionDetailsModel.fromJson(response);
  }
}
