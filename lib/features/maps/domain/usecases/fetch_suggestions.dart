import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/prediction.dart';
import '../repositories/maps_repository.dart';

class FetchSuggestionsUsecase {
  final MapsRepository repository;

  FetchSuggestionsUsecase(this.repository);
  
  Future<Either<Failure, List<Prediction>>> call(
      String place, String sessionToken) async {
    return await repository.fetchSuggestions(place, sessionToken);
  }
}
