import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/on_boarding/index.dart';

class OnBoardingPageViewBuilder extends StatelessWidget {
  const OnBoardingPageViewBuilder(
      {required this.onBoardingPageController, Key? key})
      : super(key: key);
  final PageController onBoardingPageController;
  @override
  Widget build(BuildContext context) {
    final currentListIndex =
        context.watch<OnBoardingCubit>().currentOnBoardingListIndex;
    final onBoardingCubit = context.read<OnBoardingCubit>();
    final onBoardingEntityList = onBoardingCubit.onBoardingEntityList;
    return Expanded(
      child: PageView.builder(
        itemBuilder: (context, _) {
          return OnBoardingWidget(
            imageAssetPath: onBoardingEntityList[currentListIndex].imageAsset,
            title: onBoardingEntityList[currentListIndex].title,
          );
        },
        onPageChanged: (pageIndex) => _handleOnPageChanged(
          pageIndex,
          onBoardingCubit,
        ),
        itemCount: onBoardingEntityList.length,
        controller: onBoardingPageController,
        physics: const BouncingScrollPhysics(),
      ),
    );
  }

  void _handleOnPageChanged(
    int pageIndex,
    OnBoardingCubit onBoardingCubit,
  ) {
    onBoardingCubit.changeOnBoardingIndex(pageIndex: pageIndex);
  }
}
