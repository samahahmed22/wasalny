import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/error/failures.dart';
import '../entities/address.dart';
import '../entities/direction_details.dart';
import '../entities/prediction.dart';

abstract class MapsRepository {
  Future<Either<Failure, Address>> getCurrentAddress();
  Future<Either<Failure, List<Prediction>>> fetchSuggestions(
      String place, String sessionToken);
  Future<Either<Failure, Address>> getPlaceDetails(
      String placeId, String sessionToken);
  Future<Either<Failure, DirectionDetails>> getDirections(
      LatLng start, LatLng destination);
}