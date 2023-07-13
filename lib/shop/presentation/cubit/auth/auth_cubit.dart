import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:shop_app_clean_architecture/core/index.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/auth/index.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit({
    required this.logoutUsecase,
    required this.registerUsecase,
    required this.loginUsecase,
    required this.getCachedUserDataUsecase,
  }) : super(
          AuthenticationInitialState(),
        );
  final LoginUsecase loginUsecase;
  final RegisterUsecase registerUsecase;
  final LogoutUsecase logoutUsecase;
  final GetCachedUserDataUsecase getCachedUserDataUsecase;

  void registerUser({
    required RegisterRequestEntity registerRequestEntity,
  }) async {
    emit(
      AuthenticationLoadingState(),
    );
    final response = await registerUsecase.call(
      registerRequestEntity,
    );
    response.fold((failure) {
      emit(
        AuthenticationErrorState(
          errorMessage: failure.failureMessage,
        ),
      );
    }, (registerResponse) {
      emit(
        AuthenticatedState(
          user: registerResponse.entity,
          successMessage: registerResponse.message,
        ),
      );
    });
  }

  void loginUser({
    required LoginRequestEntity loginRequestEntity,
  }) async {
    emit(AuthenticationLoadingState());
    final response = await loginUsecase.call(
      loginRequestEntity,
    );
    response.fold(
      (failure) {
        emit(
          AuthenticationErrorState(
            errorMessage: failure.failureMessage,
          ),
        );
      },
      (loginResponse) {
        emit(
          AuthenticatedState(
            user: loginResponse.entity,
            successMessage: loginResponse.message,
          ),
        );
      },
    );
  }

  void logout() async {
    emit(
      AuthenticationLoadingState(),
    );
    final response = await logoutUsecase.call(
      const NoParameters(),
    );
    response.fold((failure) {
      emit(
        AuthenticationErrorState(
          errorMessage: failure.failureMessage,
        ),
      );
    }, (logoutResponse) {
      emit(
        UnAuthenticatedState(
          logoutResponse.message,
        ),
      );
    });
  }

  Future<UserResponseEntity?> autoLogin() async{
    final response = await getCachedUserDataUsecase.call(
      const NoParameters(),
    );
    return response.fold((failure) {
    }, (cacheResponse) {
      if (cacheResponse?.token.isEmpty == true) {
        return null;
      } else {
        return cacheResponse;
      }
    });
  }
}
