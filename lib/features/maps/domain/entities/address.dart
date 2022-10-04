import 'package:equatable/equatable.dart';

class Address extends Equatable {
  final String placeId;
  final String placeName;
  final double latitude;
  final double longitude;
  final String placeFormattedAddress;

  const Address({
    required this.placeId,
    required this.latitude,
    required this.longitude,
    required this.placeName,
    required this.placeFormattedAddress,
  });

  @override
  List<Object?> get props => [placeId];
}