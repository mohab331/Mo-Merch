import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({
    required this.getProfileUseCase,
  }) : super(
          ProfileInitialState(),
        );
  final GetProfileUseCase getProfileUseCase;

  void getUerProfile() async {
    emit(ProfileLoadingState());
    final response = await getProfileUseCase.call(
      const NoParameters(),
    );
    response.fold((failure) {
      emit(
        ProfileErrorState(
          errorMessage: failure.failureMessage,
        ),
      );
    }, (profileResponse) {
      emit(
        ProfileSuccessState(
          userProfile: profileResponse.entity,
        ),
      );
    });
  }
}
