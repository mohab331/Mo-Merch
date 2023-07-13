import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/home/cubit/index.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit({
    required this.getHomeUsecase,
  }) : super(HomeInitialState());
  final GetHomeUsecase getHomeUsecase;

  void getHomeData() async {
    emit(HomeDataLoadingState());
    final response = await getHomeUsecase.call(
      const NoParameters(),
    );
    response.fold((failure) {
      emit(HomeDataErrorState(
        errorMessage: failure.failureMessage,
      ));
    }, (homeResponse) {
      emit(
        HomeDataSuccessState(
          homeResponseEntity: homeResponse.entity,
        ),
      );
    });
  }
}
