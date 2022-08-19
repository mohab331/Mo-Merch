import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_clean_architecture/core/api/end_points.dart';
import 'package:shop_app_clean_architecture/core/services/service_locator.dart'
    as di;
import 'package:shop_app_clean_architecture/core/usecase/base_usecase.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/product.dart';
import 'package:shop_app_clean_architecture/shop/domain/usecases/search/search_usecase.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/app/app_cubit.dart';
import 'package:shop_app_clean_architecture/shop/presentation/cubit/search/search_states.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  List<Product> searchProductResults = [];


  void searchProducts(
    BuildContext context, {
    required String searchValue,
  }) async {
    if (searchValue.isEmpty) {
      searchProductResults = [];
      return;
    }

    emit(SearchLoadingState());
    final response = await di.sl<SearchUseCase>().call(
          AddUseCaseParameters(
            data: {'text': searchValue},
            url: Endpoints.search,
            token: AppCubit.get(context).getUserToken(),
          ),
        );
    response.fold((failure) {
      emit(SearchErrorState(errorMessage: failure.failureMessage));
    }, (searchResponse) {
      searchProductResults =
          searchResponse.searchResponseData.searchProducts;
      emit(SearchSuccessState());
    });
  }
}
