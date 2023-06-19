import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart' as di;
import 'package:shop_app_clean_architecture/core/utils/app_images.dart';
import 'package:shop_app_clean_architecture/core/utils/app_strings.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/on_boarding/on_boarding_states.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/on_boarding_screen.dart';

import '../../../../core/usecase/base_usecase.dart';
import '../../../../core/utils/functions.dart';
import '../../../domain/usecases/cache/on_boarding/set_on_boarding_usecase.dart';
import '../../screens/login_screen.dart';

class OnBoardingCubit extends Cubit<OnBoardingStates>{

  OnBoardingCubit():super(OnBoardingInitialState());
  static OnBoardingCubit get(context) => BlocProvider.of(context);

  List boardingList = [
    const OnBoardingWidget(
      imageAssetPath: AppAssets.onBoarding1,
      title: AppStrings.onBoarding1,
      ),
    const OnBoardingWidget(
      imageAssetPath: AppAssets.onBoarding2,
      title: AppStrings.onBoarding2,
      ),
    const OnBoardingWidget(
      imageAssetPath: AppAssets.onBoarding3,
      title: AppStrings.onBoarding3,
    ),
  ];
  int currentOnBoardingIndex = 0;
  void changeOnBoardingIndex({required int pageIndex}){
    currentOnBoardingIndex = pageIndex;
    emit(OnBoardingChangeState());
  }
  void saveOnBoarding(BuildContext context)async{

    final response = await di.sl<SetOnBoardingUsecase>().call(const NoParameters());
    response.fold((failure){
    }, (isAdded){
      if (kDebugMode) {
        print(isAdded);
      }
      AppFunctions.navigateAndReplace(context: context, screen: LoginScreen(),);
    });
  }
}