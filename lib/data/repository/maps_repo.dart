import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

// import 'package:flutter_maps/data/models/Place_suggestion.dart';
// import 'package:flutter_maps/data/models/place.dart';
import '../../helpers/location_helper.dart';
import '../models/address_model.dart';
import '../models/direction_details_model.dart';
import '../models/prediction_model.dart';
import '../web_services/places_web_services.dart';

class MapsRepository {


  MapsRepository();

  static Future<AddressModel> getCurrentAddress() async {
    Position position = await LocationHelper.getCurrentLocation();
  
    String placeAddress =
        await PlacesWebservices.findCordinateAddress(position);
    AddressModel currentAddress = AddressModel(
        longitude: position.longitude,
        latitude: position.latitude,
        placeName: placeAddress);

    return currentAddress;
  }

  static Future<List<PredictionModel>> fetchSuggestions(
      String place, String sessionToken) async {

    final suggestions =
        await PlacesWebservices.fetchSuggestions(place, sessionToken);

    return suggestions
        .map((suggestion) => PredictionModel.fromJson(suggestion))
        .toList();
  }

  static Future<AddressModel> getPlaceDetails(String placeId, String sessionToken) async {
    final place =
        await PlacesWebservices.getPlaceDetails(placeId, sessionToken);
              AddressModel thisPlace = AddressModel();
      thisPlace.placeName = place['result']['name'];
      thisPlace.placeId = placeId;
      thisPlace.latitude = place ['result']['geometry']['location']['lat'];
      thisPlace.longitude = place ['result']['geometry']['location']['lng'];
    return thisPlace;
  }

  static Future<DirectionDetailsModel> getDirections(
      LatLng start, LatLng destination) async {
    final directions =
        await PlacesWebservices.getDirections(start, destination);

    return DirectionDetailsModel.fromJson(directions);
  }
}
