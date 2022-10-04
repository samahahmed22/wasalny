import 'package:equatable/equatable.dart';

class Slider extends Equatable{
  final String image;
  final String title;
  final String body;

  const Slider({
    required this.title,
    required this.image,
    required this.body,
  });

  @override
  List<Object?> get props => [ title, body, image];
}