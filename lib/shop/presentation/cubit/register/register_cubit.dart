import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/api/end_points.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart' as di;
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/core/utils/app_functions.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/register/register_usecase.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/register/register_states.dart';


class RegisterCubit extends Cubit<RegisterStates> {
  RegisterCubit() : super(RegisterInitialState());
  static RegisterCubit get(context) => BlocProvider.of(context);

  void registerUser({
    required String email,
    required String password,
    required String phoneNumber,
    required String name,
  }) async{
    emit(RegisterLoadingState());
    final response = await di.sl<RegisterUsecase>().call(AddUseCaseParameters(data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phoneNumber,
      'image': AppFunctions.image,
    }, url: Endpoints.register,));

    response.fold((failure){
      emit(RegisterErrorState(error: failure.failureMessage,),);
    }, (response){
      emit(RegisterSuccessState(message: response.message));
    });
  }
}
