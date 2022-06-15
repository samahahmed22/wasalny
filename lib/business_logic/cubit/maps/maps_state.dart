part of 'maps_cubit.dart';

@immutable
abstract class MapsState {}

class MapsInitial extends MapsState {}

class CurrentAddressLoaded extends MapsState {
  final AddressModel address;
  CurrentAddressLoaded(this.address);
}

class Loading extends MapsState {}

class PredictionsLoaded extends MapsState {
  final List<PredictionModel> places;

  PredictionsLoaded(this.places);
}

class PlaceLocationLoaded extends MapsState {
  final AddressModel place;

  PlaceLocationLoaded(this.place);
}

class DirectionsLoaded extends MapsState {
  final DirectionDetailsModel placeDirections;

  DirectionsLoaded(this.placeDirections);
}
