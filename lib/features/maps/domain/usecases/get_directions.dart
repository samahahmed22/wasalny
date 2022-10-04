import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../core/error/failures.dart';
import '../entities/direction_details.dart';
import '../repositories/maps_repository.dart';

class GetDirectionsUsecase {
  final MapsRepository repository;

  GetDirectionsUsecase(this.repository);

  Future<Either<Failure, DirectionDetails>> call(
      LatLng start, LatLng destination) async {
    return await repository.getDirections(start, destination);
  }
}
