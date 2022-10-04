import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:wasalny/features/maps/domain/usecases/get_current_address.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../domain/entities/address.dart';
import '../../../domain/entities/direction_details.dart';
import '../../../domain/entities/prediction.dart';
import '../../../domain/usecases/fetch_suggestions.dart';
import '../../../domain/usecases/get_directions.dart';
import '../../../domain/usecases/get_place_details.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  final GetCurrentAddressUsecase getCurrentAddress;
  final FetchSuggestionsUsecase fetchSuggestions;
  final GetDirectionsUsecase getDirections;
  final GetPlaceDetailsUsecase getPlaceDetails;

  MapsCubit(
      {required this.getCurrentAddress,
      required this.fetchSuggestions,
      required this.getDirections,
      required this.getPlaceDetails})
      : super(MapsInitial());

  static MapsCubit get(context) => BlocProvider.of(context);

  Address? currentAddress;
  Address? pickupAddress;
  Address? destinationAddress;

  Future<void> getCurrentPlaceAddress() async {
    emit(Loading());
    Either<Failure, Address> response = await getCurrentAddress();
    response.fold(
        (failure) => emit(ErrorOccurred(errorMsg: _mapFailureToMsg(failure))),
        (address) {
      currentAddress = address;
      emit(CurrentAddressLoaded(address: address));
    });
  }

  Future<void> getPredictions(String place, String sessionToken) async {
    Either<Failure, List<Prediction>> response =
        await fetchSuggestions(place, sessionToken);
    emit(response.fold(
        (failure) => ErrorOccurred(errorMsg: _mapFailureToMsg(failure)),
        (predictions) => PredictionsLoaded(predictions: predictions)));
  }

  void resetPredictions() {
    emit(PredictionsReseted());
  }

  Future<void> getAddressDetails(String placeId, String sessionToken) async {
    emit(Loading());

    Either<Failure, Address> response =
        await getPlaceDetails(placeId, sessionToken);
    emit(response.fold(
        (failure) => ErrorOccurred(errorMsg: _mapFailureToMsg(failure)),
        (address) => AddressDetailsLoaded(address: address)));
  }

  void setPickupAddress(Address address) async {
    pickupAddress = address;
  }

  void setDestinationAddress(Address address) async {
    destinationAddress = address;
  }

  void getDirectionDetails(LatLng start, LatLng destination) async {
    emit(Loading());
    Either<Failure, DirectionDetails> response =
        await getDirections(start, destination);
    emit(response.fold(
        (failure) => ErrorOccurred(errorMsg: _mapFailureToMsg(failure)),
        (directions) => DirectionDetailsLoaded(directions)));
  }

  void requestARide() {
    emit(RequestingARide());
  }

  void resetApp() {
    pickupAddress = null;
    destinationAddress = null;
    emit(ResetApp());
  }

  String _mapFailureToMsg(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return AppStrings.serverFailure;
      case CacheFailure:
        return AppStrings.cacheFailure;
      case OfflineFailure:
        return AppStrings.offlineFailure;

      default:
        return AppStrings.unexpectedError;
    }
  }
}
