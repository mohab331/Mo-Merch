import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shop_app_clean_architecture/shop/domain/index.dart';
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
      successWidget: ProductDetailsBody(
        product: product,
        productResponseEntity: productResponseEntity,
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

class ProductDetailsBody extends StatelessWidget {
  const ProductDetailsBody({
    required this.product,
    required this.productResponseEntity,
    Key? key,
  }) : super(key: key);

  final ProductResponseEntity product;
  final ProductResponseEntity productResponseEntity;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                    product: productResponseEntity,
                  ),
                  SizedBox(
                    height: 30.0.h,
                  ),
                  ProductNameAndPriceWidget(
                    product: product,
                    productResponseEntity: productResponseEntity,
                  ),
                  SizedBox(
                    height: 25.0.h,
                  ),
                  if (productResponseEntity.oldPrice != 0.0 &&
                      productResponseEntity.discount != 0.0)
                    ProductOldPriceAndDiscountWidget(
                      productResponseEntity: productResponseEntity,
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
    );
  }
}

