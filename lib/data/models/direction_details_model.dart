class DirectionDetailsModel{
  String? distanceText;
  String? durationText;
  int? distanceValue;
  int? durationValue;
  String? encodedPoints;

  DirectionDetailsModel({
    this.distanceText,
    this.distanceValue,
    this.durationText,
    this.durationValue,
    this.encodedPoints,
  });

  DirectionDetailsModel.fromJson(Map<String, dynamic> json){
    distanceText = json['routes'][0]['legs'][0]['distance']['text'];
    distanceValue= json['routes'][0]['legs'][0]['distance']['value'];
    durationText = json['routes'][0]['legs'][0]['duration']['text'];
    durationValue = json['routes'][0]['legs'][0]['duration']['value'];
    encodedPoints = json['routes'][0]['overview_polyline']['points'];
  }

}