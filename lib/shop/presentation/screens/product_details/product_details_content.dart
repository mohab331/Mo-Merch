import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/domain/entities/index.dart';
import 'package:shop_app_clean_architecture/shop/presentation/index.dart';

class ProductDetailsContent extends StatelessWidget {
  const ProductDetailsContent({
    required this.product,
    Key? key,
  }) : super(key: key);
  final ProductResponseEntity product;


  @override
  Widget build(BuildContext context) {
    final productDescriptionState = context.watch<ProductDetailsCubit>().state;
    final productDetailsCubit = context.read<ProductDetailsCubit>();

    final productResponseEntity =
        (productDescriptionState is ProductDescriptionSuccessState)
            ? productDescriptionState.productResponseEntity
            : product;
    return StateHandlingWidget(
      isLoading: productDescriptionState is ProductDescriptionLoadingState,
      hasError: productDescriptionState is ProductDescriptionErrorState,
      onRetryButtonPressed: () => _onReloadButtonPressed(
        productDetailsCubit,
        productResponseEntity.id,
      ),
      successWidget: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProductImagesWidget(
                      product: product,
                    ),
                    SizedBox(
                      height: 30.0.h,
                    ),
                    Text(
                      product.name,
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: 25.0.h,
                    ),
                    ProductPriceSection(
                      product: productResponseEntity,
                      showDiscountPercent: true,
                    ),
                    SizedBox(
                      height: 15.0.h,
                    ),
                    ProductDescriptionWidget(
                      productDescription: productResponseEntity.description,
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ActionsOnProductWidget(
                product: productResponseEntity,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onReloadButtonPressed(
    ProductDetailsCubit productDetailsCubit,
    int productId,
  ) {
    productDetailsCubit.getProductDetails(productId: productId);
  }
}
