import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';
import 'package:shop_app_clean_architecture/utils/index.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this.getAppThemeUseCase,
    required this.getOnBoardingUsecase,
    required this.getCachedUserDataUsecase,
  }) : super(
          SplashInitialState(),
        );

  final GetCachedUserDataUsecase getCachedUserDataUsecase;
  final GetOnBoardingUsecase getOnBoardingUsecase;
  final GetAppThemeUseCase getAppThemeUseCase;

  bool? isShowOnBoarding = true;
  AppThemeEnum? appThemeEnum = AppThemeEnum.light;
  UserResponseEntity? cachedUserData;

  void getLocalData() async {
    emit(SplashLoadingState());
    await Future.wait([
      getAppTheme(),
      getCachedUserData(),
      showOnBoarding(),
    ]).then((value) {
      mapValue(
        value,
      );
      emit(
        SplashSuccessState(
          userDataResponseEntity: cachedUserData,
          showOnBoarding: isShowOnBoarding ?? true,
          appTheme: appThemeEnum ?? AppThemeEnum.light,
        ),
      );
    }).catchError((onError) {
      emit(
        SplashErrorState(),
      );
    });
  }

  Future<AppThemeEnum> getAppTheme() async {
    final response = await getAppThemeUseCase.call(const NoParameters());
    return response.fold((failure) {
      return AppThemeEnum.light;
    }, (appThemeResponse) {
      return appThemeResponse;
    });
  }

  Future<bool> showOnBoarding() async {
    final response = await getOnBoardingUsecase.call(const NoParameters());
    return response.fold((failure) {
      return true;
    }, (showOnBoardingResponse) {
      return showOnBoardingResponse;
    });
  }

  Future<UserResponseEntity?> getCachedUserData() async {
    final response = await getCachedUserDataUsecase.call(const NoParameters());
    return response.fold((failure) {
      return null;
    }, (cachedUserDataResponse) {
      return cachedUserDataResponse;
    });
  }

  void mapValue(List<Object?> value) {
    for (final e in value) {
      if (e is AppThemeEnum) {
        appThemeEnum = e;
      } else if (e is bool) {
        isShowOnBoarding = e;
      } else {
        cachedUserData = e as UserResponseEntity?;
      }
    }
  }
}
