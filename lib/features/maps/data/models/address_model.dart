import 'package:wasalny/features/maps/domain/entities/address.dart';

class AddressModel extends Address {
  const AddressModel({
    required String placeId,
    required double latitude,
    required double longitude,
    required String placeName,
    required String placeFormattedAddress,
  }) : super(
            placeId: placeId,
            latitude: latitude,
            longitude: longitude,
            placeName: placeName,
            placeFormattedAddress: placeFormattedAddress);

  factory AddressModel.fromCoordinateAdressJson(
      Map<String, dynamic> coorinateAdress) {
    return AddressModel(
      placeName : coorinateAdress['results'][0]['address_components'][0]['long_name'],
        latitude: coorinateAdress['results'][0]['geometry']['location']['lat'],
        longitude: coorinateAdress['results'][0]['geometry']['location']['lng'],
        placeId: coorinateAdress['results'][0]['place_id'],
        placeFormattedAddress: coorinateAdress['results'][0]
            ['formatted_address']);
  }

  factory AddressModel.fromPlaceDetailsJson(Map<String, dynamic> json) {
    return AddressModel(
        placeName: json['result']['name'],
        placeId: json['result']['place_id'],
        latitude: json['result']['geometry']['location']['lat'],
        longitude: json['result']['geometry']['location']['lng'],
        placeFormattedAddress: json['result']['formatted_address']);
  }

  // factory AddressModel.fromJson(Map<String, dynamic> json) {
  //   return AddressModel(
  //     placeId: json['placeId'],
  //     placeName: json['placeName'],
  //     latitude: json['latitude'],
  //     longitude: json['longitude'],
  //     placeFormattedAddress: json['placeFormattedAddress'],
  //   );
  // }
  // Map<String, dynamic> toJson() {
  //   return {
  //     'placeId': placeId,
  //     'placeName': placeName,
  //     'latitude': latitude,
  //     'longitude': longitude,
  //     'placeFormattedAddress': placeFormattedAddress
  //   };
  // }
}
