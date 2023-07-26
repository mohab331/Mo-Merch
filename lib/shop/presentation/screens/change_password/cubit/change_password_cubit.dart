import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/change_password/cubit/index.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit({
    required this.changePasswordUsecase,
  }) : super(
          ChangePasswordInitialState(),
        );
  final ChangePasswordUsecase changePasswordUsecase;

  void changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    emit(ChangePasswordLoadingState());
    final response = await changePasswordUsecase.call(
      ChangePasswordRequestEntity(
        currentPassword: oldPassword,
        newPassword: newPassword,
      ),
    );
    response.fold((failure) {
      emit(
        ChangePasswordErrorState(
          message: failure.failureMessage,
        ),
      );
    }, (changePasswordResponse) {

      emit(
        ChangePasswordSuccessState(
          message: changePasswordResponse.message,
        ),
      );
    });
  }
}
