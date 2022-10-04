import 'package:equatable/equatable.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

class DirectionDetails extends Equatable {
  final String distanceText;
  final String durationText;
  final int distanceValue;
  final int durationValue;
  final List<PointLatLng> polylinePoints;

  const DirectionDetails({
    required this.distanceText,
    required this.distanceValue,
    required this.durationText,
    required this.durationValue,
    required this.polylinePoints,
  });

  @override
  List<Object?> get props =>
      [distanceText, distanceValue, durationText, durationValue, polylinePoints];
}
