import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/address.dart';
import '../repositories/maps_repository.dart';

class GetPlaceDetailsUsecase {
  final MapsRepository repository;

  GetPlaceDetailsUsecase(this.repository);

  Future<Either<Failure, Address>> call(
      String placeId, String sessionToken) async {
    return await repository.getPlaceDetails(placeId, sessionToken);
  }
}
