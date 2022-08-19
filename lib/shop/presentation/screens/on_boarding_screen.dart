import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/media_query.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart' as di;
import 'package:shop_app_clean_architecture/core/utils/app_colors.dart';
import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/on_boarding/on_boarding_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/on_boarding/on_boarding_states.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatelessWidget {
  OnBoardingScreen({Key? key}) : super(key: key);
  final PageController _boardingController = PageController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context)=> di.sl<OnBoardingCubit>(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            Builder(
              builder: (context) {
                return TextButton(
                  onPressed: () {
                    OnBoardingCubit.get(context).saveOnBoarding(context);
                  },
                  child: Text(
                    AppStrings.skip,
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(color: AppColors.primaryColor),
                  ),
                );
              }
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocBuilder< OnBoardingCubit, OnBoardingStates>(
            builder: (context, states) => Column(
              children: [
                Expanded(
                  child: PageView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return  OnBoardingCubit.get(context).boardingList[index];
                    },
                    onPageChanged: (int? pageIndex) {
                       OnBoardingCubit.get(context)
                          .changeOnBoardingIndex(pageIndex: pageIndex!);
                    },
                    itemCount:   OnBoardingCubit.get(context).boardingList.length,
                    controller: _boardingController,
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmoothPageIndicator(
                      controller: _boardingController,
                      count:   OnBoardingCubit.get(context).boardingList.length,
                      effect: const ExpandingDotsEffect(
                        dotColor: Colors.grey,
                        expansionFactor: 4,
                        activeDotColor: Colors.deepOrange,
                      ),
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        if (  OnBoardingCubit.get(context).currentOnBoardingIndex ==
                            ( OnBoardingCubit.get(context).boardingList.length - 1)) {
                          OnBoardingCubit.get(context).saveOnBoarding(context);
                        } else {
                          _boardingController.nextPage(
                            duration: const Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                      },
                      child: const Icon(
                        Icons.arrow_forward_ios_rounded,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

}

class OnBoardingWidget extends StatelessWidget {
  const OnBoardingWidget({
    Key? key,
    required this.imageAssetPath,
    required this.title,

  }) : super(key: key);

  final String imageAssetPath;
  final String title;


  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: Image(
          image: AssetImage(imageAssetPath),
        )),
         SizedBox(
          height: context.height * 0.02,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          height: context.height * 0.02,
        ),

      ],
    );
  }
}
