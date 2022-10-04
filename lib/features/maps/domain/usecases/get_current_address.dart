import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/address.dart';
import '../repositories/maps_repository.dart';

class GetCurrentAddressUsecase {
  final MapsRepository repository;

  GetCurrentAddressUsecase(this.repository);

  Future<Either<Failure, Address>> call() async {
    return await repository.getCurrentAddress();
  }
}
