import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/search/cubit/index.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit({
    required this.searchUseCase,
  }) : super(
          SearchInitialState(),
        );

  final SearchUseCase searchUseCase;

  void searchProducts({
    required String searchString,
  }) async {
    emit(SearchLoadingState());
    final response = await searchUseCase.call(
      SearchRequestEntity(
        text: searchString,
      ),
    );
    response.fold((failure) {
      emit(
        SearchErrorState(
          errorMessage: failure.failureMessage,
        ),
      );
    }, (searchResponse) {
      emit(
        SearchSuccessState(
          products: searchResponse.entityList,
        ),
      );
    });
  }
}
