import 'package:wasalny/features/maps/domain/entities/prediction.dart';

class PredictionModel extends Prediction {
  const PredictionModel({
    required String placeId,
    required String mainText,
    required String secondaryText,
  }) : super(
            placeId: placeId, mainText: mainText, secondaryText: secondaryText);

  factory PredictionModel.fromJson(Map<String, dynamic> json) {
    return PredictionModel(
      placeId: json['place_id'],
      mainText: json['structured_formatting']['main_text'],
      secondaryText: json['structured_formatting']['secondary_text'],
    );
  }
}
