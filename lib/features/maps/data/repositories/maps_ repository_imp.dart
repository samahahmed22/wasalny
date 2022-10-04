import 'package:dartz/dartz.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:wasalny/features/maps/data/datasources/maps_remote_data_source.dart';
import 'package:wasalny/features/maps/domain/entities/address.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/network/network_info.dart';
import '../../domain/entities/direction_details.dart';
import '../../domain/entities/prediction.dart';
import '../../domain/repositories/maps_repository.dart';

class MapsRepositoryImpl implements MapsRepository {
  final MapsRemoteDataSource _mapsRemoteDataSource;
  final NetworkInfo _networkInfo;

  MapsRepositoryImpl(
    this._mapsRemoteDataSource,
    this._networkInfo,
  );

  @override
  Future<Either<Failure, Address>> getCurrentAddress() async {
    if (await _networkInfo.isConnected) {
      try {
        return Right(await _mapsRemoteDataSource.getCurrentAddress());
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, List<Prediction>>> fetchSuggestions(
      String place, String sessionToken) async {
    if (await _networkInfo.isConnected) {
      try {
        final predictions =
            await _mapsRemoteDataSource.fetchSuggestions(place, sessionToken);

        return Right(predictions);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, Address>> getPlaceDetails(
      String placeId, String sessionToken) async {
    if (await _networkInfo.isConnected) {
      try {
        final address =
            await _mapsRemoteDataSource.getPlaceDetails(placeId, sessionToken);

        return Right(address);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, DirectionDetails>> getDirections(
      LatLng start, LatLng destination) async {
    if (await _networkInfo.isConnected) {
      try {
        final directions =
            await _mapsRemoteDataSource.getDirections(start, destination);
        return Right(directions);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
