import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates> {
  OnBoardingCubit({
    required this.setOnBoardingUsecase,
  }) : super(
          OnBoardingInitialState(),
        );
  final SetOnBoardingUsecase setOnBoardingUsecase;

  List<OnBoardingEntity> onBoardingEntityList = [
    OnBoardingEntity(
      title: R.strings.onBoarding1,
      imageAsset: R.images.onBoarding1,
    ),
    OnBoardingEntity(
      title: R.strings.onBoarding2,
      imageAsset: R.images.onBoarding2,
    ),
    OnBoardingEntity(
      title: R.strings.onBoarding3,
      imageAsset: R.images.onBoarding3,
    ),
  ];
  int currentOnBoardingListIndex = 0;

  void changeOnBoardingIndex({
    required int pageIndex,
  }) {
    currentOnBoardingListIndex = pageIndex;
    emit(
      OnBoardingChangeState(),
    );
  }

  void saveOnBoarding() async {
    await setOnBoardingUsecase.call(
      false,
    );
  }
}

class OnBoardingEntity {
  const OnBoardingEntity({
    required this.title,
    required this.imageAsset,
  });
  final String imageAsset;
  final String title;
}
