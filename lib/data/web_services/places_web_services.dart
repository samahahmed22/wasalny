import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../shared/constants.dart';

class PlacesWebservices {
  static Dio dio= Dio(
      BaseOptions(
        connectTimeout: 20 * 1000,
        receiveTimeout: 20 * 1000,
        receiveDataWhenStatusError: true,
      ),
    );

  
  static Future<String> findCordinateAddress(Position position) async {
    String placeAddress = '';

    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult != ConnectivityResult.mobile &&
        connectivityResult != ConnectivityResult.wifi) {
      return placeAddress;
    }
    try {
      Response response = await dio.get(
        cordinateAddressBaseUrl,
        queryParameters: {
          'latlng': '${position.latitude},${position.longitude}',
          'key': googleAPIKey,
        },
      );
      print(response.data);
      if (response != 'failed') {
        placeAddress = response.data['results'][0]['formatted_address'];
      }

      return placeAddress;
    } catch (error) {
      print(error.toString());
      return placeAddress;
    }
  }

  static Future<List<dynamic>> fetchSuggestions(
      String place, String sessionToken) async {
    try {
      Response response = await dio.get(
        suggestionsBaseUrl,
        queryParameters: {
          'input': place,
          'types': 'address',
          'components': 'country:sa',
          'key': googleAPIKey,
          'sessiontoken': sessionToken
        },
      );
      print(response.data['predictions']);
      print(response.statusCode);
      return response.data['predictions'];
    } catch (error) {
      print(error.toString());
      return [];
    }
  }

  static Future<dynamic> getPlaceDetails(
      String placeId, String sessionToken) async {
    try {
      Response response = await dio.get(
        placeDetailsBaseUrl,
        queryParameters: {
          'place_id': placeId,
          'fields': 'geometry',
          'key': googleAPIKey,
          'sessiontoken': sessionToken
        },
      );
      return response.data;
    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }

  // origin equals current location
  // destination equals searched for location
  static Future<dynamic> getDirections(
      LatLng start, LatLng destination) async {
    try {
      Response response = await dio.get(
        directionsBaseUrl,
        queryParameters: {
          'origin': '${start.latitude},${start.longitude}',
          'destination': '${destination.latitude},${destination.longitude}',
          'mode': 'driving',
          'key': googleAPIKey,
        },
      );
      print(response.data);
      return response.data;
    } catch (error) {
      return Future.error("Place location error : ",
          StackTrace.fromString(('this is its trace')));
    }
  }
}
