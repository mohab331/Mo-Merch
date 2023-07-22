import 'package:bloc/bloc.dart';
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

  UserResponseEntity? loggedInUser;

  void setLoggedInUser(UserResponseEntity? user) {
    loggedInUser = user;
  }

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
          message: failure.failureMessage,
        ),
      );
    }, (registerResponse) {
      loggedInUser = registerResponse.entity;
      emit(
        AuthenticatedState(
          user: registerResponse.entity,
          message: registerResponse.message,
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
            message: failure.failureMessage,
          ),
        );
      },
      (loginResponse) {
        loggedInUser = loginResponse.entity;
        emit(
          AuthenticatedState(
            user: loginResponse.entity,
            message: loginResponse.message,
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
          message: failure.failureMessage,
        ),
      );
    }, (logoutResponse) {
      emit(
        UnAuthenticatedState(
          message: logoutResponse.message,
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
        loggedInUser = cacheResponse;
        return cacheResponse;
      }
    });
  }
}
