import 'package:equatable/equatable.dart';

class Prediction extends Equatable {
  final String placeId;
  final String mainText;
  final String secondaryText;

  const Prediction({
    required this.placeId,
    required this.mainText,
    required this.secondaryText,
  });
  @override
  List<Object?> get props => [placeId];
}
