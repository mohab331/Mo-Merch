import 'package:bloc/bloc.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/screens/product_details/cubit/index.dart';

class ProductDetailsCubit extends Cubit<ProductDescriptionState> {
  ProductDetailsCubit({
    required this.productDetailsUc,
  }) : super(
          ProductDescriptionInitialState(),
        );
  final GetProductDetailsUc productDetailsUc;

  void getProductDetails({
    required int productId,
  }) async {
    emit(ProductDescriptionLoadingState());
    final response = await productDetailsUc.call(productId);
    response.fold((failure) {
      emit(
        ProductDescriptionErrorState(
          errorMessage: failure.failureMessage,
        ),
      );
    }, (productDetailsResponse) {
      emit(
        ProductDescriptionSuccessState(
          productResponseEntity: productDetailsResponse.entity,
        ),
      );
    });
  }
}
