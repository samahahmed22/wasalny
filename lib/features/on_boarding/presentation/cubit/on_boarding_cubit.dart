import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../domain/entities/slider.dart';
part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit() : super(OnBoardingInitial());

  static OnBoardingCubit get(context) => BlocProvider.of(context);

  final List<Slider> _list = [
    Slider(
      image: ImgAssets.onboarding1,
      title: AppStrings.onBoardingTitle1,
      body: AppStrings.onBoardingBody1,
    ),
    Slider(
      image: ImgAssets.onboarding2,
      title: AppStrings.onBoardingTitle2,
      body: AppStrings.onBoardingBody2,
    ),
    Slider(
      image: ImgAssets.onboarding3,
      title: AppStrings.onBoardingTitle3,
      body: AppStrings.onBoardingBody3,
    ),
  ];

  int _currentIndex = 0;

  int get sliderlength => _list.length;

  int get nextIndex {
    int nextIndex = _currentIndex + 1;
    if (nextIndex == _list.length) {
      nextIndex = 0;
    }
    return nextIndex;
  }

  int get previousIndex {
    int previousIndex = _currentIndex - 1;
    if (previousIndex == -1) {
      previousIndex = _list.length - 1;
    }
    return previousIndex;
  }

  Slider get currentPage => _list[_currentIndex];

  void changePage(int pageIndex) {
    _currentIndex = pageIndex;
    emit(PageChanged(_list[pageIndex]));
  }
}
