import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit({
    required this.getCategoryUsecase,
  }) : super(
          CategoryInitialState(),
        );
  final GetCategoryUsecase getCategoryUsecase;

  List<CategoryResponseEntity> categories = [];
  bool hasNext = true;
  int currentPage = 1;

  void getCategories({
    required int page,
    bool fromReload = false,
  }) async {
    if (page == 1) {
      hasNext = true;
      currentPage = 1;
      categories = [];
    }
    if (hasNext == false && !fromReload) {
      return;
    }
    emit(CategoryLoadingState());
    final response = await getCategoryUsecase.call(
      page,
    );
    response.fold((failure) {
      emit(
        CategoryErrorState(
          errorMessage: failure.failureMessage,
        ),
      );
    }, (categoryResponse) {
      categories.addAll(
        categoryResponse.entityList,
      );
      hasNext = (categoryResponse.nextPageUrl != null);
      currentPage = categoryResponse.currentPage ?? currentPage;
      emit(
        CategorySuccessState(
          categoriesList: categories,
        ),
      );
    });
  }
}
