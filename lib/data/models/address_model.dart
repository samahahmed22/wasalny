class AddressModel {
  String? placeId;
  String? placeName;
  double? latitude;
  double? longitude;
  String? placeFormattedAddress;

  AddressModel({
    this.placeId,
    this.latitude,
    this.longitude,
    this.placeName,
    this.placeFormattedAddress,
  });
}
