import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:meta/meta.dart';
import 'package:geolocator/geolocator.dart';
import 'package:wasalny/data/models/address_model.dart';
import 'package:wasalny/data/models/prediction_model.dart';

import '../../../data/models/direction_details_model.dart';
import '../../../data/repository/maps_repo.dart';
import '../../../data/web_services/places_web_services.dart';
import '../../../helpers/location_helper.dart';

part 'maps_state.dart';

class MapsCubit extends Cubit<MapsState> {
  MapsCubit() : super(MapsInitial());

  static MapsCubit get(context) => BlocProvider.of(context);

  AddressModel? pickupAddress;
  AddressModel? destinationAddress;

  Future<void> getCurrentAddress() async {
    emit(Loading());
    pickupAddress = await MapsRepository.getCurrentAddress();

    emit(CurrentAddressLoaded(pickupAddress!));
  }

  Future<void> findCordinateAddress() async {}

  void getPredictions(String place, String sessionToken) {
    MapsRepository.fetchSuggestions(place, sessionToken).then((suggestions) {
      emit(PredictionsLoaded(suggestions));
    });
  }

  updatePickupAddress(String placeId, String sessionToken) {
    emit(Loading());
    MapsRepository.getPlaceDetails(placeId, sessionToken).then((place) {
      pickupAddress = place;
      emit(PlaceLocationLoaded(place));
    });
  }

  updateDestinationAddress(String placeId, String sessionToken) {
    emit(Loading());
    MapsRepository.getPlaceDetails(placeId, sessionToken).then((place) {
      destinationAddress = place;
      emit(PlaceLocationLoaded(place));
    });
  }

  void getPlaceDirections(LatLng start, LatLng destination) {
    emit(Loading());
    MapsRepository.getDirections(start, destination).then((directions) {
      emit(DirectionsLoaded(directions));
    });
  }
}
