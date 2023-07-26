import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/common_widgets/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/on_boarding/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingContent extends HookWidget {
  const OnBoardingContent({
    Key? key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final onBoardingPageController = usePageController();
    final onBoardingCubit = context.read<OnBoardingCubit>();
    final onBoardingEntityList = onBoardingCubit.onBoardingEntityList;
    final currentListIndex =
        context.watch<OnBoardingCubit>().currentOnBoardingListIndex;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: R.colors.whiteColor,
        actions: [
          CustomTextButton(
            buttonPadding: const EdgeInsets.all(
              16.0,
            ),
            label: R.strings.skip,
            onPressed: () => _handleEndOfOnBoardingScreen(
              onBoardingCubit,
              context,
            ),
            textColor: R.colors.primaryColor,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(
          20.0,
        ),
        child: BlocBuilder<OnBoardingCubit, OnBoardingStates>(
          builder: (context, states) {
            return Column(
              children: [
                OnBoardingPageViewBuilder(
                  onBoardingPageController: onBoardingPageController,
                ),
                SizedBox(
                  height: 35.0.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: onBoardingPageController,
                      count: onBoardingEntityList.length,
                      effect: ExpandingDotsEffect(
                        expansionFactor: 2.8,
                        activeDotColor: R.colors.primaryColor,
                      ),
                    ),
                    OnBoardingNavigationWidget(
                      currentListIndex: currentListIndex,
                      onBoardingEntityListLength: onBoardingEntityList.length,
                      onFloatingButtonPressed: () =>
                          _handleOnFloatingButtonPressed(
                        onBoardingPageController,
                      ),
                      onGoPressed: () => _handleEndOfOnBoardingScreen(
                        onBoardingCubit,
                        context,
                      ),
                    ),
                  ],
                )
              ],
            );
          },
        ),
      ),
    );
  }

  void _handleOnFloatingButtonPressed(
    PageController onBoardingPageController,
  ) {
    onBoardingPageController.nextPage(
      duration: const Duration(
        milliseconds: 750,
      ),
      curve: Curves.fastLinearToSlowEaseIn,
    );
  }

  void _handleEndOfOnBoardingScreen(
    OnBoardingCubit onBoardingCubit,
    BuildContext context,
  ) {
    onBoardingCubit.saveOnBoarding();
    context.navigator.navigateToLoginScreen();
  }
}
