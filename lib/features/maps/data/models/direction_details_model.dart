import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:wasalny/features/maps/domain/entities/direction_details.dart';

class DirectionDetailsModel extends DirectionDetails {
  const DirectionDetailsModel({
    required String distanceText,
    required int distanceValue,
    required String durationText,
    required int durationValue,
    required List<PointLatLng> polylinePoints,
  }) : super(
            distanceText: distanceText,
            distanceValue: distanceValue,
            durationText: durationText,
            durationValue: durationValue,
            polylinePoints: polylinePoints);

  factory DirectionDetailsModel.fromJson(Map<String, dynamic> json) {
    return DirectionDetailsModel(
      distanceText: json['routes'][0]['legs'][0]['distance']['text'],
      distanceValue: json['routes'][0]['legs'][0]['distance']['value'],
      durationText: json['routes'][0]['legs'][0]['duration']['text'],
      durationValue: json['routes'][0]['legs'][0]['duration']['value'],
      polylinePoints: PolylinePoints()
          .decodePolyline(json['routes'][0]['overview_polyline']['points']),
    );
  }
}
