import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:wasalny/core/utils/app_colors.dart';
import 'package:wasalny/features/on_boarding/presentation/widgets/boarding_item.dart';

import '../../../../config/routes/app_routes.dart';
import '../cubit/on_boarding_cubit.dart';



class OnBoardingScreen extends StatelessWidget {
  final PageController _boardController = PageController();

  // void submit() {
  //   CacheHelper.saveData(
  //     key: 'onBoarding',
  //     value: true,
  //   ).then((value) {
  //     if (value) {
  //       Navigator.pushReplacementNamed(context, Routes.loginScreenRoute);
  //     }
  //   });
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () => Navigator.pushReplacementNamed(
                context, Routes.loginScreenRoute),
            child: Text(
              'Skip',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                reverse: true,
                physics: BouncingScrollPhysics(),
                controller: _boardController,
                onPageChanged: (int index) {
           
                  OnBoardingCubit.get(context).changePage(index);
                },
                itemBuilder: (context, index) => BoardingItem(),
                itemCount: OnBoardingCubit.get(context).sliderlength,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    _boardController.animateToPage(
                      OnBoardingCubit.get(context).previousIndex,
                      duration: Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  icon: Icon(
                    Icons.arrow_back_ios,
                  ),
                ),
                Spacer(),
                SmoothPageIndicator(
                  controller: _boardController,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: AppColors.primary,
                    dotHeight: 10,
                    expansionFactor: 4,
                    dotWidth: 10,
                    spacing: 5.0,
                  ),
                  count: OnBoardingCubit.get(context).sliderlength,
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    _boardController.animateToPage(
                      OnBoardingCubit.get(context).nextIndex,
                      duration: Duration(
                        milliseconds: 750,
                      ),
                      curve: Curves.fastLinearToSlowEaseIn,
                    );
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
