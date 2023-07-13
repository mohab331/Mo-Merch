import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/edit_personal_data/cubit/edit_personal_data_state.dart';

class EditPersonalDataCubit extends Cubit<EditPersonalDataState> {
  EditPersonalDataCubit({
    required this.updateProfileUseCase,
  }) : super(
          EditPersonalDataInitialState(),
        );
  final UpdateProfileUseCase updateProfileUseCase;

  void updateUserProfile({
    required UpdateProfileRequestEntity updateProfileRequestEntity,
  }) async {
    emit(
      EditPersonalDataLoadingState(),
    );
    final response = await updateProfileUseCase.call(
      updateProfileRequestEntity,
    );
    response.fold((failure) {
      emit(
        EditPersonalDataErrorState(
          message: failure.failureMessage,
        ),
      );
    }, (updateResponse) {
      emit(
        EditPersonalDataSuccessState(
          message: updateResponse.message,
        ),
      );
    });
  }
}
