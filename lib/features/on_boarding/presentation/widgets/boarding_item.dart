import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/on_boarding_cubit.dart';
import '../../domain/entities/slider.dart' as slider;

class BoardingItem extends StatelessWidget {
  late slider.Slider _sliderObject;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnBoardingCubit, OnBoardingState>(
        buildWhen: (previous, current) => current is PageChanged,
        builder: (context, state) {
          if (state is PageChanged) {
            _sliderObject = (state).sliderObject;
          } else {
            _sliderObject = OnBoardingCubit.get(context).currentPage;
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Image(
                  image: AssetImage(_sliderObject.image),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  _sliderObject.title,
                  // textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText1,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  _sliderObject.body,
                  // textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
              ),
              const SizedBox(height: 40),
            ],
          );
        });
  }
}