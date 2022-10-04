import 'package:wasalny/features/on_boarding/domain/entities/slider.dart';

class SliderModel extends Slider {
  const SliderModel({
    required String title,
    required String image,
    required String body,
  }) : super(image: image, title: title, body: body);
}
