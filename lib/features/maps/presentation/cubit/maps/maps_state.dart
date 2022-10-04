part of 'maps_cubit.dart';

@immutable
abstract class MapsState extends Equatable {
  const MapsState();

  @override
  List<Object> get props => [];
}

class MapsInitial extends MapsState {}

class Loading extends MapsState {}

class CurrentAddressLoaded extends MapsState {
  final Address address;

  CurrentAddressLoaded({required this.address});

  @override
  List<Object> get props => [address];
}

class AddressDetailsLoaded extends MapsState {
  final Address address;

  AddressDetailsLoaded({required this.address});

  @override
  List<Object> get props => [address];
}

class PredictionsLoaded extends MapsState {
  final List<Prediction> predictions;

  PredictionsLoaded({required this.predictions});

  @override
  List<Object> get props => [predictions];
}

class PredictionsReseted extends MapsState {}

class DirectionDetailsLoaded extends MapsState {
  final DirectionDetails directionDetails;

  DirectionDetailsLoaded(this.directionDetails);

  @override
  List<Object> get props => [directionDetails];
}

class ErrorOccurred extends MapsState {
  final String errorMsg;

  ErrorOccurred({required this.errorMsg});

  @override
  List<Object> get props => [errorMsg];
}

class RequestingARide extends MapsState {}
class ResetApp extends MapsState {}
